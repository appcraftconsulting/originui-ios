//
//  OriginButtonStyle.swift
//  OriginUI
//
//  Created by François Boulais on 27/11/2024.
//

import SwiftUI

extension ButtonStyle where Self == OriginButtonStyle {
    public static var origin: Self {
        .origin()
    }
    
    public static func origin(
        level: OriginButtonLevel = .default,
        shape: OriginButtonShape = .default,
        loaderPlacement: OriginButtonLoaderPlacement? = nil,
        fullWidth: Bool = false
    ) -> Self {
        .init(
            level: level,
            shape: shape,
            loaderPlacement: loaderPlacement,
            fullWidth: fullWidth
        )
    }
}

public struct OriginButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    let level: OriginButtonLevel
    let shape: OriginButtonShape
    let loaderPlacement: OriginButtonLoaderPlacement?
    let fullWidth: Bool
    
    private struct ForegroundModifier: ViewModifier {
        let configuration: Configuration
        let level: OriginButtonLevel
        
        private var color: Color {
            switch level {
            case .primary:
                switch configuration.role {
                case .destructive:
                    return Color(.destructiveForeground)
                default:
                    return Color(.primaryForeground)
                }
            case .secondary, .tertiary:
                return Color(.secondaryForeground)
            }
        }
        
        func body(content: Content) -> some View {
            content
                .foregroundStyle(color)
        }
    }
    
    private struct BackgroundModifier: ViewModifier {
        let configuration: Configuration
        let level: OriginButtonLevel
        let shape: OriginButtonShape
        
        private var background: Color {
            switch level {
            case .primary:
                switch configuration.role {
                case .destructive:
                    return Color(.destructive).opacity(configuration.isPressed ? 0.9 : 1.0)
                default:
                    return Color(.originPrimary).opacity(configuration.isPressed ? 0.9 : 1.0)
                }
            case .secondary:
                return Color(.originSecondary).opacity(configuration.isPressed ? 0.8 : 1.0)
            case .tertiary:
                return configuration.isPressed ? Color(.accent) : Color(.background)
            }
        }
        
        private var hasBorder: Bool {
            switch level {
            case .primary, .secondary:
                return false
            case let .tertiary(hasBorder):
                return hasBorder
            }
        }
        
        func body(content: Content) -> some View {
            switch shape {
            case .capsule:
                content
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .padding(hasBorder ? 0 : 1)
                    .background(background, in: .capsule)
                    .padding(hasBorder ? 0.5 : 0)
            case .rounded:
                content
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .padding(hasBorder ? 0 : 1)
                    .background(background, in: .rect(cornerRadius: .radius(.lg)))
                    .padding(hasBorder ? 0.5 : 0)
            case .circle:
                content
                    .padding(8)
                    .padding(hasBorder ? 0 : 1)
                    .background(background, in: .circle)
                    .padding(hasBorder ? 0.5 : 0)
            case .square:
                content
                    .padding(8)
                    .padding(hasBorder ? 0 : 1)
                    .background(background, in: .rect(cornerRadius: .radius(.lg)))
                    .padding(hasBorder ? 0.5 : 0)
            }
        }
    }
    
    private struct BorderModifier: ViewModifier {
        let level: OriginButtonLevel
        let shape: OriginButtonShape
        
        var borderColor: Color? {
            switch level {
            case .primary, .secondary, .tertiary(hasBorder: false):
                return nil
            case .tertiary(hasBorder: true):
                return Color(.border)
            }
        }
        
        func body(content: Content) -> some View {
            if let borderColor {
                content
                    .overlay {
                        switch shape {
                        case .capsule:
                            Capsule()
                                .stroke(borderColor, lineWidth: 1)
                        case .rounded:
                            RoundedRectangle(cornerRadius: .radius(.lg) + 1)
                                .stroke(borderColor, lineWidth: 1)
                        case .circle:
                            Circle()
                                .stroke(borderColor, lineWidth: 1)
                        case .square:
                            RoundedRectangle(cornerRadius: .radius(.lg) + 1)
                                .stroke(borderColor, lineWidth: 1)
                        }
                    }
                    .padding(0.5)
            } else {
                content
            }
        }
    }
    
    private struct ShadowModifier: ViewModifier {
        let level: OriginButtonLevel
        
        private var hasShadow: Bool {
            switch level {
            case .primary, .secondary:
                return true
            case let .tertiary(hasBorder):
                return hasBorder
            }
        }
        
        func body(content: Content) -> some View {
            if hasShadow {
                content
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
            } else {
                content
            }
        }
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            if loaderPlacement == .left {
                OriginLoaderCircle()
            }
            
            configuration.label
                .labelStyle(OriginButtonLabelStyle(shape: shape))
                .lineLimit(1)
        }
        .frame(maxWidth: fullWidth ? .infinity : nil)
        .opacity(loaderPlacement == .overlay ? 0.0 : 1.0)
        .overlay {
            if loaderPlacement == .overlay {
                OriginLoaderCircle()
            }
        }
        .font(.system(size: 16, weight: .medium))
        .modifier(ForegroundModifier(configuration: configuration, level: level))
        .modifier(BackgroundModifier(configuration: configuration, level: level, shape: shape))
        .modifier(BorderModifier(level: level, shape: shape))
        .compositingGroup()
        .modifier(ShadowModifier(level: level))
        .opacity(isEnabled ? 1.0 : 0.5)
        .animation(.easeInOut(duration: 0.15), value: loaderPlacement)
    }
}

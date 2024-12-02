//
//  OriginInputOverlayModifier.swift
//  OriginUI
//
//  Created by François Boulais on 30/11/2024.
//

import SwiftUI

struct OriginInputOverlayModifier: ViewModifier {
    @Environment(\.isEnabled) private var isEnabled
    
    let isFocused: Bool
    var isColored: Bool = false
    var hasError: Bool = false
    
    var roundedCorners: [UIRectCorner] = [.allCorners]
    
    private let borderWidth: CGFloat = 1
    private let ringWidth: CGFloat = 3
    
    private var ringColor: Color {
        if hasError {
            return Color(.destructive)
        } else if isColored {
            return .accentColor
        } else {
            return Color(.ring)
        }
    }
    
    private var borderColor: Color {
        if hasError {
            return Color(.destructive)
        } else if isFocused {
            if isColored {
                return .accentColor
            } else {
                return Color(.ring)
            }
        } else {
            return Color(.input)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack {
                    let externalRadius: CGFloat = .radius(.lg) + borderWidth + (isFocused ? ringWidth : 0)
                    let internalRadius: CGFloat = .radius(.lg) + borderWidth
                    
                    UnevenRoundedRectangle(
                        topLeadingRadius: topLeadingRadius(externalRadius),
                        bottomLeadingRadius: bottomLeadingRadius(externalRadius),
                        bottomTrailingRadius: bottomTrailingRadius(externalRadius),
                        topTrailingRadius: topTrailingRadius(externalRadius),
                        style: .circular
                    )
                    .fill(ringColor.opacity(0.20))
                    .padding(-borderWidth - (isFocused ? ringWidth : 0))
                    
                    UnevenRoundedRectangle(
                        topLeadingRadius: topLeadingRadius(internalRadius),
                        bottomLeadingRadius: bottomLeadingRadius(internalRadius),
                        bottomTrailingRadius: bottomTrailingRadius(internalRadius),
                        topTrailingRadius: topTrailingRadius(internalRadius),
                        style: .circular
                    )
                    .padding(-borderWidth)
                    .blendMode(.destinationOut)
                }
                .compositingGroup()
                .allowsHitTesting(false)
            }
            .overlay {
                ZStack {
                    let externalRadius: CGFloat = .radius(.lg) + borderWidth
                    let internalRadius: CGFloat = .radius(.lg)
                    
                    UnevenRoundedRectangle(
                        topLeadingRadius: topLeadingRadius(externalRadius),
                        bottomLeadingRadius: bottomLeadingRadius(externalRadius),
                        bottomTrailingRadius: bottomTrailingRadius(externalRadius),
                        topTrailingRadius: topTrailingRadius(externalRadius),
                        style: .circular
                    )
                    .fill(borderColor)
                    .padding(-borderWidth)
                    
                    UnevenRoundedRectangle(
                        topLeadingRadius: topLeadingRadius(internalRadius),
                        bottomLeadingRadius: bottomLeadingRadius(internalRadius),
                        bottomTrailingRadius: bottomTrailingRadius(internalRadius),
                        topTrailingRadius: topTrailingRadius(internalRadius),
                        style: .circular
                    )
                    .blendMode(.destinationOut)
                }
                .compositingGroup()
                .allowsHitTesting(false)
            }
            .animation(.easeInOut(duration: 0.15), value: isFocused)
            .padding(borderWidth)
    }
    
    // MARK: - Private functions
    
    private func topLeadingRadius(_ radius: CGFloat) -> CGFloat {
        roundedCorners.contains(.allCorners) || roundedCorners.contains(.topLeft) ? radius : .zero
    }
    
    private func bottomLeadingRadius(_ radius: CGFloat) -> CGFloat {
        roundedCorners.contains(.allCorners) || roundedCorners.contains(.bottomLeft) ? radius : .zero
    }
    
    private func topTrailingRadius(_ radius: CGFloat) -> CGFloat {
        roundedCorners.contains(.allCorners) || roundedCorners.contains(.topRight) ? radius : .zero
    }
    
    private func bottomTrailingRadius(_ radius: CGFloat) -> CGFloat {
        roundedCorners.contains(.allCorners) || roundedCorners.contains(.bottomRight) ? radius : .zero
    }
}

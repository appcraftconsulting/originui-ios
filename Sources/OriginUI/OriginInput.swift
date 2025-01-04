//
//  OriginInput.swift
//  OriginUI
//
//  Created by François Boulais on 29/11/2024.
//

import SwiftUI

public let OriginInputLayout = VStackLayout(alignment: .leading, spacing: .gap(.gap2dot5))

public struct OriginInput<StartAddon: View, EndAddon: View, Content: View>: View {
    @Environment(\.isEnabled) private var isEnabled
    @FocusState private var isFocused
    
    private let title: LocalizedStringKey?
    private let hint: LocalizedStringKey?
    private let helperText: LocalizedStringKey?
    private let errorText: LocalizedStringKey?
    private let bundle: Bundle?
    private let isRequired: Bool
    private let isColored: Bool
    private let background: OriginInputBackground
    private let roundedCorners: [UIRectCorner]
    private let textField: () -> Content
    private let startAddon: (() -> StartAddon)?
    private let endAddon: (() -> EndAddon)?

    public init(
        _ title: LocalizedStringKey? = nil,
        hint: LocalizedStringKey? = nil,
        helperText: LocalizedStringKey? = nil,
        errorText: LocalizedStringKey? = nil,
        bundle: Bundle? = nil,
        isRequired: Bool = false,
        isColored: Bool = false,
        background: OriginInputBackground = .default,
        roundedCorners: [UIRectCorner] = [.allCorners],
        @ViewBuilder textField: @escaping () -> Content
    ) where StartAddon == EmptyView, EndAddon == EmptyView {
        self.title = title
        self.hint = hint
        self.helperText = helperText
        self.errorText = errorText
        self.bundle = bundle
        self.isRequired = isRequired
        self.isColored = isColored
        self.background = background
        self.roundedCorners = roundedCorners
        self.textField = textField
        self.startAddon = nil
        self.endAddon = nil
        
        configureTextEditorPadding()
    }
    
    public init(
        _ title: LocalizedStringKey? = nil,
        hint: LocalizedStringKey? = nil,
        helperText: LocalizedStringKey? = nil,
        errorText: LocalizedStringKey? = nil,
        bundle: Bundle? = nil,
        isRequired: Bool = false,
        isColored: Bool = false,
        background: OriginInputBackground = .default,
        roundedCorners: [UIRectCorner] = [.allCorners],
        @ViewBuilder textField: @escaping () -> Content,
        @ViewBuilder startAddon: @escaping () -> StartAddon
    ) where EndAddon == EmptyView {
        self.title = title
        self.hint = hint
        self.helperText = helperText
        self.errorText = errorText
        self.bundle = bundle
        self.isRequired = isRequired
        self.isColored = isColored
        self.background = background
        self.roundedCorners = roundedCorners
        self.textField = textField
        self.startAddon = startAddon
        self.endAddon = nil
        
        configureTextEditorPadding()
    }
    
    public init(
        _ title: LocalizedStringKey? = nil,
        hint: LocalizedStringKey? = nil,
        helperText: LocalizedStringKey? = nil,
        errorText: LocalizedStringKey? = nil,
        bundle: Bundle? = nil,
        isRequired: Bool = false,
        isColored: Bool = false,
        background: OriginInputBackground = .default,
        roundedCorners: [UIRectCorner] = [.allCorners],
        @ViewBuilder textField: @escaping () -> Content,
        @ViewBuilder endAddon: @escaping () -> EndAddon
    ) where StartAddon == EmptyView {
        self.title = title
        self.hint = hint
        self.helperText = helperText
        self.errorText = errorText
        self.bundle = bundle
        self.isRequired = isRequired
        self.isColored = isColored
        self.background = background
        self.roundedCorners = roundedCorners
        self.textField = textField
        self.startAddon = nil
        self.endAddon = endAddon
        
        configureTextEditorPadding()
    }
    
    public init(
        _ title: LocalizedStringKey? = nil,
        hint: LocalizedStringKey? = nil,
        helperText: LocalizedStringKey? = nil,
        errorText: LocalizedStringKey? = nil,
        bundle: Bundle? = nil,
        isRequired: Bool = false,
        isColored: Bool = false,
        background: OriginInputBackground = .default,
        roundedCorners: [UIRectCorner] = [.allCorners],
        @ViewBuilder textField: @escaping () -> Content,
        @ViewBuilder startAddon: @escaping () -> StartAddon,
        @ViewBuilder endAddon: @escaping () -> EndAddon
    ) {
        self.title = title
        self.hint = hint
        self.helperText = helperText
        self.errorText = errorText
        self.bundle = bundle
        self.isRequired = isRequired
        self.isColored = isColored
        self.background = background
        self.roundedCorners = roundedCorners
        self.textField = textField
        self.startAddon = startAddon
        self.endAddon = endAddon
        
        configureTextEditorPadding()
    }
    
    public var body: some View {
        OriginInputLayout {
            OriginInputHeader(
                title: title,
                hint: hint,
                isRequired: isRequired,
                bundle: bundle
            )

            HStack(spacing: .zero) {
                if let startAddon {
                    startAddon()
                        .foregroundStyle(.origin.mutedForeground)
                        .padding(.leading, 12)
                        .lineLimit(1)
                }
                
                textField()
                    .foregroundStyle(.origin.foreground)
                    .modifier(OriginInputPaddingModifier(hasStartAddon: startAddon != nil, hasEndAddon: endAddon != nil))
                    .focused($isFocused)
                    .lineLimit(1)
                
                if let endAddon {
                    endAddon()
                        .foregroundStyle(.origin.mutedForeground)
                        .padding(.trailing, 12)
                        .lineLimit(1)
                }
            }
            .font(.system(size: 16, weight: .regular))
            .modifier(
                OriginInputBackgroundModifier(
                    background: background,
                    roundedCorners: roundedCorners
                )
            )
            .modifier(
                OriginInputOverlayModifier(
                    isFocused: isFocused,
                    isColored: isColored,
                    hasError: errorText != nil,
                    roundedCorners: roundedCorners
                )
            )
            .compositingGroup()
            .modifier(OriginInputShadowModifier(background: background))
            .opacity(isEnabled ? 1.0 : 0.5)
            
            Group {
                if let errorText {
                    Text(errorText, bundle: bundle)
                        .foregroundStyle(.origin.destructive)
                } else if let helperText {
                    Text(helperText, bundle: bundle)
                        .foregroundStyle(Color(.mutedForeground))
                }
            }
            .font(.system(size: 14, weight: .regular))
            .multilineTextAlignment(.leading)
        }
    }
    
    // MARK: - Private functions
    
    private func configureTextEditorPadding() {
        UITextView.appearance().textContainerInset =
             UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
    }
}

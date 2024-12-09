//
//  OriginMiniSegmentedControl.swift
//  OriginUI
//
//  Created by François Boulais on 06/12/2024.
//

import SwiftUI

public struct OriginMiniSegmentedControl<Choice, Label>: View where Choice: Identifiable, Label: View {
    @Environment(\.isEnabled) var isEnabled
    @Namespace private var namespace
    @Binding private var selection: Choice
    
    private let choices: [Choice]
    private let label: (Choice) -> Label
    
    public init(
        choices: [Choice],
        selection: Binding<Choice>,
        @ViewBuilder label: @escaping (Choice) -> Label
    ) {
        self.choices = choices
        self._selection = selection
        self.label = label
    }
    
    private enum Identifier: String {
        case selector
    }
    
    public var body: some View {
        HStack(spacing: .zero) {
            ForEach(choices) { choice in
                Button {
                    selection = choice
                } label: {
                    label(choice)
                        .frame(width: 16, height: 16, alignment: .center)
                        .frame(width: 32, height: 32, alignment: .center)
                }
                .buttonStyle(.plain)
                .allowsHitTesting(choice.id != selection.id)
                .foregroundStyle(choice.id == selection.id ? Color.origin.foreground : Color.origin.mutedForeground.opacity(0.70))
                .background {
                    if choice.id == selection.id {
                        Circle()
                            .fill(Color.origin.background)
                            .matchedGeometryEffect(id: Identifier.selector.rawValue, in: namespace)
                    }
                }
                .accessibilityAddTraits(choice.id == selection.id ? [.isSelected] : [])
                .accessibilityRemoveTraits(choice.id == selection.id ? [.isButton] : [])
            }
        }
        .padding(2)
        .background {
            Capsule()
                .fill(Color.origin.input.opacity(0.5))
        }
        .compositingGroup()
        .opacity(isEnabled ? 1.0 : 0.5)
        .animation(.easeInOut(duration: 0.15), value: selection.id)
    }
}

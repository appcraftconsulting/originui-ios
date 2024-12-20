//
//  RatingPicker.swift
//  OriginUI
//
//  Created by François Boulais on 15/12/2024.
//

import SwiftUI

public struct RatingPicker: View {
    @Environment(\.isEnabled) private var isEnabled

    let title: LocalizedStringKey
    let leadingHelperText: LocalizedStringKey?
    let trailingHelperText: LocalizedStringKey?
    @Binding var selection: Int?
    let range: ClosedRange<Int>
    
    public init(
        title: LocalizedStringKey,
        leadingHelperText: LocalizedStringKey? = nil,
        trailingHelperText: LocalizedStringKey? = nil,
        selection: Binding<Int?>,
        range: ClosedRange<Int> = 1...5
    ) {
        self.title = title
        self.leadingHelperText = leadingHelperText
        self.trailingHelperText = trailingHelperText
        self._selection = selection
        self.range = range
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.origin.foreground)
            
            HStack(spacing: -1) {
                ForEach(range, id: \.self) { rate in
                    Button {
                        selection = rate
                    } label: {
                        Text(rate, format: .number)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(.origin.foreground)
                    .background(rate == selection ? .origin.accent : .origin.background)
                    .overlay {
                        UnevenRoundedRectangle(
                            topLeadingRadius: rate == range.min() ? .radius(.lg) : .zero,
                            bottomLeadingRadius: rate == range.min() ? .radius(.lg) : .zero,
                            bottomTrailingRadius: rate == range.max() ? .radius(.lg) : .zero,
                            topTrailingRadius: rate == range.max() ? .radius(.lg) : .zero,
                            style: .circular
                        )
                        .stroke(selection == rate ? .origin.ring : .origin.border, lineWidth: 1)
                    }
                    .zIndex(selection == rate ? 10 : 1)
                }
            }
            .compositingGroup()
            .originShadow(.sm)
            .opacity(isEnabled ? 1.0 : 0.5)
            
            HStack(alignment: .top, spacing: .zero) {
                if let leadingHelperText {
                    Text(leadingHelperText)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer(minLength: 16)

                if let trailingHelperText {
                    Text(trailingHelperText)
                        .multilineTextAlignment(.trailing)
                }
            }
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(.origin.mutedForeground)
        }
    }
}

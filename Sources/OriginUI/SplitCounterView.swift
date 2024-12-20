//
//  SplitCounterView.swift
//  OriginUI
//
//  Created by François Boulais on 08/12/2024.
//

import SwiftUI

public struct SplitCounterView: View {
    public struct Component: Identifiable, Equatable {
        let index: Int
        let value: Int
        let unit: String
        
        public init(index: Int, value: Int, unit: String) {
            self.index = index
            self.value = value
            self.unit = unit
        }
        
        // MARK: - Identifiable
        
        public var id: Int {
            index
        }
    }
    
    private let components: [Component]
    
    public init(components: [Component]) {
        self.components = components
    }
    
    public var body: some View {
        HStack(spacing: 1) {
            ForEach(components) { component in
                Group {
                    Text(component.value, format: .number)
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                        .foregroundStyle(.origin.foreground)
                    +
                    Text(component.unit)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.origin.mutedForeground)
                }
                .padding(8)
                .background(
                    .origin.primary.opacity(0.15),
                    in: UnevenRoundedRectangle(
                        topLeadingRadius: component == components.first ? .radius(.lg) : .zero,
                        bottomLeadingRadius: component == components.first ? .radius(.lg) : .zero,
                        bottomTrailingRadius: component == components.last ? .radius(.lg) : .zero,
                        topTrailingRadius: component == components.last ? .radius(.lg) : .zero,
                        style: .circular
                    )
                )
            }
        }
    }
}

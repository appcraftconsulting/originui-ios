//
//  OriginForm.swift
//  OriginUI
//
//  Created by François Boulais on 29/12/2024.
//

import SwiftUI

public struct OriginForm<Content: View>: View {
    private var spacing: CGFloat
    private var content: () -> Content
    
    public init(spacing: CGFloat = .gap(.gap4), @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: spacing) {
                content()
            }
            .padding(.gap(.gap4))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.origin.foreground)
        .background(.origin.background)
    }
}

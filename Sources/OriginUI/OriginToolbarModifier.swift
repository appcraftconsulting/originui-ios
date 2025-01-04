//
//  OriginToolbarModifier.swift
//  OriginUI
//
//  Created by François Boulais on 02/12/2024.
//

import SwiftUI

public extension View {
    func originToolbar<Toolbar: View>(edge: VerticalEdge = .bottom, @ViewBuilder toolbar: @escaping () -> Toolbar) -> some View {
        modifier(OriginToolbarModifier(toolbar: toolbar, edge: edge))
    }
}

struct OriginToolbarModifier<Toolbar: View>: ViewModifier {
    @ViewBuilder var toolbar: () -> Toolbar
    
    let edge: VerticalEdge
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: edge, spacing: .zero) {
                VStack(spacing: .zero) {
                    if edge == .bottom {
                        Color.origin.border
                            .frame(height: 1)
                    }

                    HStack(spacing: 16) {
                        toolbar()
                            .buttonStyle(.origin)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(.origin.foreground)
                    .background(.origin.background)
                    
                    if edge == .top {
                        Color.origin.border
                            .frame(height: 1)
                    }
                }
            }
    }
}

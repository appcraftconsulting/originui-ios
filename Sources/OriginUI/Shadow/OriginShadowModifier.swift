//
//  OriginShadowModifier.swift
//  OriginUI
//
//  Created by François Boulais on 09/12/2024.
//

import SwiftUI

public extension View {
    func originShadow(_ shadow: OriginShadow) -> some View {
        modifier(OriginShadowModifier(shadow: shadow))
    }
}

struct OriginShadowModifier: ViewModifier {
    let shadow: OriginShadow
    
    func body(content: Content) -> some View {
        switch shadow {
        case let .sm(color):
            content
                .shadow(color: color, radius: 2, x: 0, y: 1)
        case let .lg(color):
            content
                .shadow(color: color, radius: 15, x: 0, y: 10) // spread: -3
                .shadow(color: color, radius: 6, x: 0, y: 4) // spread: -4
        }
    }
}

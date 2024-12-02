//
//  OriginInputShadowModifier.swift
//  OriginUI
//
//  Created by François Boulais on 01/12/2024.
//

import SwiftUI

struct OriginInputShadowModifier: ViewModifier {
    let background: OriginInputBackground
    
    private var hasShadow: Bool {
        switch background {
        case .default:
            return true
        case .gray:
            return false
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

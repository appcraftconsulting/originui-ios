//
//  OriginInputPaddingModifier.swift
//  OriginUI
//
//  Created by François Boulais on 29/11/2024.
//

import SwiftUI

struct OriginInputPaddingModifier: ViewModifier {
    let hasStartAddon: Bool
    let hasEndAddon: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(.leading, hasStartAddon ? 6 : 12)
            .padding(.trailing, hasEndAddon ? 6 : 12)
            .padding(.vertical, 8)
    }
}

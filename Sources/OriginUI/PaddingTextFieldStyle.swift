//
//  PaddingTextFieldStyle.swift
//  OriginUI
//
//  Created by François Boulais on 29/11/2024.
//

import SwiftUI

extension TextFieldStyle where Self == PaddingTextFieldStyle {
    static func padding(hasStartAddon: Bool, hasEndAddon: Bool) -> PaddingTextFieldStyle {
        .init(hasStartAddon: hasStartAddon, hasEndAddon: hasEndAddon)
    }
}

struct PaddingTextFieldStyle: @preconcurrency TextFieldStyle {
    let hasStartAddon: Bool
    let hasEndAddon: Bool
    
    @MainActor
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration.body
            .padding(.leading, hasStartAddon ? 6 : 12)
            .padding(.trailing, hasEndAddon ? 6 : 12)
            .padding(.vertical, 8)
    }
}

//
//  OriginButtonLabelStyle.swift
//  OriginUI
//
//  Created by François Boulais on 29/11/2024.
//

import SwiftUI

struct OriginButtonLabelStyle: LabelStyle {
    let shape: OriginButtonShape
    
    private var hasTitle: Bool {
        shape == .rounded || shape == .capsule
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 8) {
            configuration.icon
                .opacity(hasTitle ? 0.6 : 1.0)
            
            if hasTitle {
                configuration.title
            }
        }
    }
}

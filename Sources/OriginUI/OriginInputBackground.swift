//
//  OriginInputBackground.swift
//  OriginUI
//
//  Created by François Boulais on 01/12/2024.
//

import SwiftUI

public enum OriginInputBackground {
    case `default`, gray
    
    var color: Color {
        switch self {
        case .default:
            Color(.background)
        case .gray:
            Color(.muted)
        }
    }
}

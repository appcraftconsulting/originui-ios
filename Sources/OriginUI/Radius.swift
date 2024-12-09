//
//  Radius.swift
//  OriginUI
//
//  Created by François Boulais on 21/11/2024.
//

import Foundation

public enum Radius {
    case lg, md, sm
    
    var value: CGFloat {
        switch self {
        case .lg:
            return 8
        case .md:
            return Radius.lg.value - 2
        case .sm:
            return Radius.lg.value - 4
        }
    }
}

public extension CGFloat {
    static func radius(_ radius: Radius) -> Self {
        radius.value
    }
}

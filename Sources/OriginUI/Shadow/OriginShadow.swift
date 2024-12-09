//
//  OriginShadow.swift
//  OriginUI
//
//  Created by François Boulais on 09/12/2024.
//

import SwiftUI

public enum OriginShadow: Sendable{
    case lg(color: Color = .black.opacity(0.10))
    case sm(color: Color = .black.opacity(0.05))
    
    public static let lg = Self.lg()
    public static let sm = Self.sm()
}

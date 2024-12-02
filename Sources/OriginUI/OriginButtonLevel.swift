//
//  OriginButtonLevel.swift
//  OriginUI
//
//  Created by François Boulais on 29/11/2024.
//

public enum OriginButtonLevel: Hashable, Sendable {
    case primary
    case secondary
    case tertiary(hasBorder: Bool)
    
    public static let `default`: Self = .primary
}

//
//  Color.swift
//  OriginUI
//
//  Created by François Boulais on 02/12/2024.
//

import SwiftUI

public extension Color {
    static let origin = OriginColor()
}

public extension ShapeStyle where Self == Color {
    static var origin: OriginColor { .init() }
}

public struct OriginColor: Sendable {
    public let border = Color(.border)
    public let background = Color(.background)
    public let muted = Color(.muted)
    public let mutedForeground = Color(.mutedForeground)
    public let foreground = Color(.foreground)
    public let input = Color(.input)
    public let accent = Color(.accent)
    public let ring = Color(.ring)
    public let primaryForeground = Color(.primaryForeground)
    public let primary = Color(.originPrimary)
    public let secondary = Color(.originSecondary)
    public let emerald500 = Color(.emerald500)
    public let destructive = Color(.destructive)
}

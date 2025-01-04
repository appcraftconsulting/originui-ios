//
//  TailwindGap.swift
//  OriginUI
//
//  Created by François Boulais on 29/12/2024.
//

import Foundation

public enum TailwindGap: CGFloat {
    case gap0dot5 = 2
    case gap1 = 4
    case gap1dot5 = 6
    case gap2 = 8
    case gap2dot5 = 10
    case gap3 = 12
    case gap3dot5 = 14
    case gap4 = 16
    case gap5 = 20
    case gap6 = 24
    case gap7 = 28
    case gap8 = 32
    case gap9 = 36
    case gap10 = 40
    case gap11 = 44
    case gap12 = 48
    case gap14 = 56
    case gap16 = 64
    case gap20 = 80
    case gap24 = 96
    case gap28 = 112
    case gap32 = 128
    case gap36 = 144
    case gap40 = 160
    case gap44 = 176
    case gap48 = 192
    case gap52 = 208
    case gap56 = 224
    case gap60 = 240
    case gap64 = 256
    case gap72 = 288
    case gap80 = 320
    case gap96 = 384
}

public extension CGFloat {
    static func gap(_ gap: TailwindGap) -> Self {
        gap.rawValue
    }
}

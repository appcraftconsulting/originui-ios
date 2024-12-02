//
//  OriginInputBackgroundModifier.swift
//  OriginUI
//
//  Created by François Boulais on 01/12/2024.
//

import SwiftUI

struct OriginInputBackgroundModifier: ViewModifier {
    var background: OriginInputBackground = .default
    var roundedCorners: [UIRectCorner] = [.allCorners]
    
    func body(content: Content) -> some View {
        content
            .background {
                UnevenRoundedRectangle(
                    topLeadingRadius: topLeadingRadius(.radius(.lg)),
                    bottomLeadingRadius: bottomLeadingRadius(.radius(.lg)),
                    bottomTrailingRadius: bottomTrailingRadius(.radius(.lg)),
                    topTrailingRadius: topTrailingRadius(.radius(.lg)),
                    style: .circular
                )
                .fill(background.color)
            }
    }

    // MARK: - Private functions

    private func topLeadingRadius(_ radius: CGFloat) -> CGFloat {
        roundedCorners.contains(.allCorners) || roundedCorners.contains(.topLeft) ? radius : .zero
    }

    private func bottomLeadingRadius(_ radius: CGFloat) -> CGFloat {
        roundedCorners.contains(.allCorners) || roundedCorners.contains(.bottomLeft) ? radius : .zero
    }

    private func topTrailingRadius(_ radius: CGFloat) -> CGFloat {
        roundedCorners.contains(.allCorners) || roundedCorners.contains(.topRight) ? radius : .zero
    }

    private func bottomTrailingRadius(_ radius: CGFloat) -> CGFloat {
        roundedCorners.contains(.allCorners) || roundedCorners.contains(.bottomRight) ? radius : .zero
    }
}

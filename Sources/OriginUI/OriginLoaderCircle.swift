//
//  OriginLoaderCircle.swift
//  OriginUI
//
//  Created by François Boulais on 29/11/2024.
//

import SwiftUI

struct OriginLoaderCircle: View {
    @State private var isAnimating = false

    var body: some View {
        Image(.loaderCircle)
            .rotationEffect(.radians(isAnimating ? 2 * .pi : .zero))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
            .onAppear {
              isAnimating = true
            }
    }
}

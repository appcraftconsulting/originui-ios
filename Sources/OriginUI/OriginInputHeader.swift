//
//  OriginInputHeader.swift
//  OriginUI
//
//  Created by François Boulais on 04/01/2025.
//

import SwiftUI

public struct OriginInputHeader: View {
    private let title: LocalizedStringKey?
    private let hint: LocalizedStringKey?
    private let isRequired: Bool
    private let bundle: Bundle?
    
    public init(
        title: LocalizedStringKey? = nil,
        hint: LocalizedStringKey? = nil,
        isRequired: Bool = false,
        bundle: Bundle? = nil
    ) {
        self.title = title
        self.hint = hint
        self.isRequired = isRequired
        self.bundle = bundle
    }

    public var body: some View {
        if title != nil || hint != nil {
            HStack(alignment: .center, spacing: .gap(.gap2)) {
                if let title {
                    Group {
                        if isRequired {
                            Text(title, bundle: bundle) + Text(verbatim: " *").foregroundStyle(.origin.destructive)
                        } else {
                            Text(title, bundle: bundle)
                        }
                    }
                    .foregroundStyle(.origin.foreground)
                    .font(.system(size: 16, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                }
                
                if let hint {
                    Text(hint, bundle: bundle)
                        .foregroundStyle(.origin.mutedForeground)
                        .font(.system(size: 16, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
}

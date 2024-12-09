//
//  ShowNotificationAction.swift
//  OriginUI
//
//  Created by François Boulais on 08/12/2024.
//

import SwiftUI

public struct ShowNotificationAction: Equatable {
    private var id = UUID()
    var handler: (LocalizedStringKey?, String?, Bundle?, Notification.`Type`) -> Void

    public init(handler: @escaping (LocalizedStringKey?, String?, Bundle?, Notification.`Type`) -> Void) {
        self.handler = handler
    }

    public func callAsFunction(_ message: LocalizedStringKey, bundle: Bundle?, type: Notification.`Type`) {
        handler(message, nil, bundle, type)
    }
    
    public func callAsFunction(_ message: String, type: Notification.`Type`) {
        handler(nil, message, nil, type)
    }

    public static func == (lhs: ShowNotificationAction, rhs: ShowNotificationAction) -> Bool {
        lhs.id == rhs.id
    }
}

public extension EnvironmentValues {
    @Entry var showNotification: ShowNotificationAction = .init { _, _, _, _ in
        assertionFailure()
    }
}

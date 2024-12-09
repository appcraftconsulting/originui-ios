//
//  NotificationsOverlayModifier.swift
//  OriginUI
//
//  Created by François Boulais on 08/12/2024.
//

import SwiftUI

public extension View {
    func installOriginNotificationsEngine() -> some View {
        modifier(NotificationsOverlayModifier())
    }
}

struct NotificationsOverlayModifier: ViewModifier {
    @State private var notificationsManager = OriginNotificationsManager()

    func body(content: Content) -> some View {
        content
            .environment(notificationsManager)
            .environment(\.showNotification, ShowNotificationAction { localized, message, bundle, type in
                let notification = Notification(localized: localized, message: message, type: type, bundle: bundle)
                notificationsManager.add(notification)
            })
            .onAppear(perform: addBannersViewToUIWindow)
    }
    
    // MARK: - Private functions
    
    private func addBannersViewToUIWindow() {
        let windows = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
        
        let swiftUIView = OriginNotificationsListView(notificationsManager: notificationsManager)
        let uiKitView = UIHostingController(rootView: swiftUIView).view
        uiKitView?.translatesAutoresizingMaskIntoConstraints = false
        uiKitView?.backgroundColor = .clear
        uiKitView?.isUserInteractionEnabled = false
                
        if let window = windows.first, let uiKitView {
            window.addSubview(uiKitView)
            NSLayoutConstraint.activate([
                uiKitView.topAnchor.constraint(equalTo: window.topAnchor),
                uiKitView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                uiKitView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                uiKitView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            ])
        }
    }
}

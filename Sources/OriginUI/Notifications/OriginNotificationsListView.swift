//
//  OriginNotificationsListView.swift
//  OriginUI
//
//  Created by François Boulais on 08/12/2024.
//

import SwiftUI

struct OriginNotificationsListView: View {
    let notificationsManager: OriginNotificationsManager

    private var notifications: [Notification] {
        Array(notificationsManager.notifications.suffix(3).reversed())
    }
    
    var body: some View {
        ScrollView(.vertical) {
            ZStack(alignment: .bottom) {
                ForEach(Array(zip(notifications.indices, notifications)), id: \.1.id) { index, notification in
                    OriginNotificationView(notification: notification)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .scaleEffect(1 - CGFloat(index) * 0.05)
                        .offset(y: CGFloat(index) * 14)
                        .zIndex(CGFloat(-index))
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .originShadow(.lg(color: .black.opacity(0.05)))
        }
        .scrollDisabled(true)
        .defaultScrollAnchor(.top)
        .animation(.easeInOut(duration: 0.15), value: notificationsManager.notifications)
        .environment(notificationsManager)
    }
}

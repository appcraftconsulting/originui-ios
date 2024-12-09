//
//  OriginNotificationsManager 2.swift
//  OriginUI
//
//  Created by François Boulais on 08/12/2024.
//

import Foundation

@Observable final class OriginNotificationsManager {
    private var timers = [String : Timer]()
    
    var notifications = [Notification]()
    
    func add(_ notification: Notification) {
        if let index = notifications.firstIndex(where: { $0.key == notification.key }) {
            notifications[index] = notification
        } else {
            notifications.append(notification)
        }
    }
    
    func removeNotification(with key: String) {
        timers[key]?.invalidate()
        timers.removeValue(forKey: key)
        notifications.removeAll(where: { $0.key == key })
    }
}

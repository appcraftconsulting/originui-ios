//
//  OriginNotificationsManager.swift
//  OriginUI
//
//  Created by François Boulais on 05/12/2024.
//

import SwiftUI

public extension View {
    func installOriginNotificationsEngine() -> some View {
        modifier(NotificationsOverlayModifier())
    }
    
    func originNotification(_ title: LocalizedStringKey, type: Notification.`Type`, trigger: Bool) -> some View {
        modifier(OriginPostNotificationModifier(title: title, type: type, trigger: trigger))
    }
}

struct OriginPostNotificationModifier: ViewModifier {
    @Environment(OriginNotificationsManager.self) private var notificationsManager

    let title: LocalizedStringKey
    let type: Notification.`Type`
    let trigger: Bool
    
    func body(content: Content) -> some View {
        content
            .onChange(of: trigger) { oldValue, newValue in
                if newValue {
                    let notification = Notification(title: title, type: type)
                    notificationsManager.add(notification)
                }
            }
    }
}

struct NotificationsOverlayModifier: ViewModifier {
    @State private var notificationsManager = OriginNotificationsManager()

    func body(content: Content) -> some View {
        content
            .environment(notificationsManager)
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

public struct Notification: Equatable {
    public enum `Type` {
        case success, info, warning, error
    }
    
    let key: String
    let title: LocalizedStringKey
    let type: `Type`
    let bundle: Bundle?
    let duration: TimeInterval?
    
    init(
        title: LocalizedStringKey,
        type: `Type` = .info,
        key: String? = nil,
        duration: TimeInterval? = 3,
        bundle: Bundle? = nil
    ) {
        self.key = key ?? UUID().uuidString
        self.title = title
        self.type = type
        self.bundle = bundle
        self.duration = duration
    }
}

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

struct OriginNotificationsListView: View {
    let notificationsManager: OriginNotificationsManager

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 16) {
                ForEach(notificationsManager.notifications.reversed(), id: \.key) { notification in
                    OriginNotificationView(notification: notification)
                        .transition(.asymmetric(insertion: .move(edge: .top), removal: .slide.combined(with: .opacity)))
                }
            }
            .padding(16)
        }
        .scrollDisabled(true)
        .defaultScrollAnchor(.top)
        .animation(.default, value: notificationsManager.notifications)
        .environment(notificationsManager)
    }
}

struct OriginNotificationView: View {
    @Environment(OriginNotificationsManager.self) private var notificationsManager

    let notification: Notification
    
    var body: some View {
        Text(notification.title, bundle: notification.bundle)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(.white, in: RoundedRectangle(cornerRadius: 6))
            .shadow(radius: 3)
            .onAppear {
                if let duration = notification.duration {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        notificationsManager.removeNotification(with: notification.key)
                    }
                }
            }
    }
    
    // MARK: - Private functions
    
    private func dismiss() {
        notificationsManager.removeNotification(with: notification.key)
    }
}

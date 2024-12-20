//
//  OriginNotificationView.swift
//  OriginUI
//
//  Created by François Boulais on 08/12/2024.
//

import SwiftUI

public struct OriginNotificationView: View {
    @Environment(OriginNotificationsManager.self) private var notificationsManager

    private let notification: Notification
    
    public init(notification: Notification) {
        self.notification = notification
    }
    
    private var iconSystemName: String {
        switch notification.type {
        case .success:
            return "checkmark.circle"
        case .info:
            return "info.circle"
        case .warning:
            return "exclamationmark.triangle"
        case .error:
            return "exclamationmark.circle"
        }
    }
    
    private var iconColor: Color {
        if notification.isBanner {
            return textColor.opacity(0.60)
        } else {
            return mainColor
        }
    }
    
    var textColor: Color {
        if notification.isBanner {
            switch notification.type {
            case .success:
                return Color(.emerald600)
            case .info:
                return Color(.blue600)
            case .warning:
                return Color(.amber600)
            case .error:
                return Color(.red600)
            }
        } else {
            return .origin.foreground
        }
    }
    
    private var borderColor: Color {
        if notification.isBanner {
            return mainColor.opacity(0.50)
        } else {
            return .origin.border
        }
    }
    
    private var mainColor: Color {
        switch notification.type {
        case .success:
            return Color(.emerald500)
        case .info:
            return Color(.blue500)
        case .warning:
            return Color(.amber600)
        case .error:
            return Color(.red500)
        }
    }
    
    public var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Image(systemName: iconSystemName)
                .foregroundStyle(iconColor)
            
            if let localized = notification.localized {
                Text(localized, bundle: notification.bundle)
            } else if let message = notification.message {
                Text(message)
            }
        }
        .foregroundStyle(textColor)
        .tint(textColor)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.system(size: 16, weight: .regular))
        .multilineTextAlignment(.leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .padding(0.5)
        .overlay(content: {
            RoundedRectangle(cornerRadius: .radius(.lg))
                .stroke(borderColor, lineWidth: 1)
        })
        .padding(0.5)
        .background(
            Color.origin.background,
            in: RoundedRectangle(cornerRadius: .radius(.lg))
        )
        .compositingGroup()
        .onAppear {
            if let duration = notification.duration, !notification.isBanner {
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + duration,
                    execute: dismiss
                )
            }
        }
    }
    
    // MARK: - Private functions
    
    private func dismiss() {
        notificationsManager.removeNotification(with: notification.key)
    }
}

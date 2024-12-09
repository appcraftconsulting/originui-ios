//
//  OriginNotificationsManager.swift
//  OriginUI
//
//  Created by François Boulais on 05/12/2024.
//

import SwiftUI

public struct Notification: Equatable, Identifiable {
    public enum `Type` {
        case success, info, warning, error
    }
    
    let key: String
    let localized: LocalizedStringKey?
    let message: String?
    let type: `Type`
    let bundle: Bundle?
    let duration: TimeInterval?
    let isBanner: Bool
    
    public init(
        message: String?,
        type: `Type` = .info
    ) {
        self.key = UUID().uuidString
        self.localized = nil
        self.message = message
        self.type = type
        self.bundle = nil
        self.duration = nil
        self.isBanner = true
    }
    
    public init(
        localized: LocalizedStringKey?,
        type: `Type` = .info,
        bundle: Bundle? = nil
    ) {
        self.key = UUID().uuidString
        self.localized = localized
        self.message = nil
        self.type = type
        self.bundle = bundle
        self.duration = nil
        self.isBanner = true
    }
    
    internal init(
        localized: LocalizedStringKey?,
        message: String?,
        type: `Type` = .info,
        key: String? = nil,
        duration: TimeInterval? = 3,
        bundle: Bundle? = nil
    ) {
        self.key = key ?? UUID().uuidString
        self.localized = localized
        self.message = message
        self.type = type
        self.bundle = bundle
        self.duration = duration
        self.isBanner = false
    }
    
    // MARK: - Identifiable
    
    public var id: String {
        key
    }
}

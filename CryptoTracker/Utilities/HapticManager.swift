//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 17/01/2024.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}

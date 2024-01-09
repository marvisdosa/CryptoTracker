//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 09/01/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

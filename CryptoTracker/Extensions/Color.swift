//
//  Color.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 08/01/2024.
//

import Foundation
import SwiftUI
 

extension Color{
    static let theme = colorTheme()
}

struct colorTheme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    let green = Color ("GreenColor")
}

//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 15/12/2023.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}

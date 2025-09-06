//
//  RavenApp.swift
//  Raven
//
//  Created by Matheus Silva on 18/08/25.
//

import SwiftUI

@main
struct RavenApp: App {
    var body: some Scene {
        
        WindowGroup {
            let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
            
            if hasSeenOnboarding {
                ContentView()
            } else {
                HistoriesView()
            }
            
        }
    }
}

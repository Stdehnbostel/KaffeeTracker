//
//  KaffeeTrackerApp.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import SwiftUI

@main
struct KaffeeTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Home", systemImage: "house.fill") {
                    HomeView()
                }
                
                Tab("Übersicht", systemImage: "list.dash") {
                    ListView()
                }
            }
        }
    }
}

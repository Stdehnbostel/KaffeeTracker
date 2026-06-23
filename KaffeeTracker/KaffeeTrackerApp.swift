//
//  KaffeeTrackerApp.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import SwiftData
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
        .modelContainer(for: CoffeeType.self) { result in
            // if there are no coffeeTypes available, we pre-Populate the app with our DefaultCoffeeTypes
            do {
                let container = try result.get()
                
                let descriptor = FetchDescriptor<CoffeeType>()
                let existingCoffeeTypes = try container.mainContext.fetchCount(descriptor)
                
                guard existingCoffeeTypes == 0 else { return }
                
                guard let url = Bundle.main.url(forResource: "DefaultCoffeeTypes", withExtension: "json") else {
                    // Throw fatal error as this should never happen.
                    fatalError("Unable find DefaultCoffeeTypes.json in Bundle.")
                }
                
                let data = try Data(contentsOf: url)
                let defaultCoffeeTypes = try JSONDecoder().decode([CoffeeType].self, from: data)
                
                for type in defaultCoffeeTypes {
                    container.mainContext.insert(type)
                }
            } catch {
                print("Failed to load the default CoffeeTypes")
            }
        }
    }
}


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
    let container: ModelContainer
    
    init() {
        do {
            let schema = Schema([
                Coffee.self,
                CoffeeType.self
            ])
            let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            let container = try ModelContainer(for: schema, configurations: [configuration])
            
            let descriptor = FetchDescriptor<CoffeeType>()
            let existingCoffeeTypes = try container.mainContext.fetchCount(descriptor)
            
            if existingCoffeeTypes == 0 {
                guard let url = Bundle.main.url(forResource: "DefaultCoffeeTypes", withExtension: "json") else {
                    // Throw fatal error as this should never happen.
                    fatalError("Unable find DefaultCoffeeTypes.json in Bundle.")
                }
                
                let data = try Data(contentsOf: url)
                let defaultCoffeeTypes = try JSONDecoder().decode([CoffeeType].self, from: data)
                
                for type in defaultCoffeeTypes {
                    container.mainContext.insert(type)
                }
            }
            
            self.container = container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Home", systemImage: "house.fill") {
                    HomeView()
                }
                
                Tab("Übersicht", systemImage: "list.dash") {
                    ListView()
                }
                
                Tab("Sorten", systemImage: "book.circle") {
                    CoffeeTypesListView()
                }
            }
            .tint(.cremaInk)
        }
        .modelContainer(container)
    }
}


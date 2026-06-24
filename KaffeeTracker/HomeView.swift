//
//  ContentView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Query(sort: \CoffeeType.defaultPrice) var coffeeTypes: [CoffeeType]
    @State private var showNewCoffeSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CoffeeCardView(title: "Diese Woche")
                .padding()
                
                CoffeeCardView(title: "Gesamt")
                .padding()
                
                VStack {
                    Text("Verlauf")
                }
                .padding()
                .navigationTitle("Kaffee Tracker")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button {
                        showNewCoffeSheet = true
                    } label: {
                        Label("Hinzufügen", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {} label: {
                        Label("Einstellungen", systemImage: "gear")
                    }
                }
            }
            .background(.cremaBackground)
            .sheet(isPresented: $showNewCoffeSheet) {
                if let defaultSelection = coffeeTypes.first {
                    NewCoffeeView(defaultType: defaultSelection)
                } else {
                    Text("Es können derzeit keine Kaffees hinzugefügt werden.")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

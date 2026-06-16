//
//  ContentView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import SwiftUI

struct HomeView: View {
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
                    Button {} label: {
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
                NewCoffeeView()
            }
        }
    }
}

#Preview {
    HomeView()
}

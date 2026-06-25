//
//  ContentView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import Charts
import SwiftData
import SwiftUI

struct coffeeDay: Identifiable {
    var date: Date
    var cost: Double
    var id = UUID()
}

struct HomeView: View {
    @Query(sort: \CoffeeType.defaultPrice) var coffeeTypes: [CoffeeType]
    @Query(sort: \Coffee.date) var coffees: [Coffee]
    @State private var showNewCoffeSheet: Bool = false
    
    let placeholderData = [
        coffeeDay(date: .now.startOfWeek ?? .now, cost: 14.2),
        coffeeDay(date: Calendar.current.date(byAdding: .day, value: 1, to: .now.startOfWeek ?? .now) ?? .now, cost: 8),
        coffeeDay(date: Calendar.current.date(byAdding: .day, value: 2, to: .now.startOfWeek ?? .now) ?? .now, cost: 12.4),
        coffeeDay(date: Calendar.current.date(byAdding: .day, value: 3, to: .now.startOfWeek ?? .now) ?? .now, cost: 6),
        coffeeDay(date: Calendar.current.date(byAdding: .day, value: 4, to: .now.startOfWeek ?? .now) ?? .now, cost: 0),
        coffeeDay(date: Calendar.current.date(byAdding: .day, value: 5, to: .now.startOfWeek ?? .now) ?? .now, cost: 0),
        coffeeDay(date: Calendar.current.date(byAdding: .day, value: 6, to: .now.startOfWeek ?? .now) ?? .now, cost: 0)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CoffeeCardView(title: "Diese Woche", numberOfCoffees: currentWeeksCoffees().count, cost: currentWeeksCoffees().map(\.price).reduce(0, +), volume: currentWeeksCoffees().map(\.volume).reduce(0, +))
                        .padding(.bottom)
                    
                    CoffeeCardView(title: "Gesamt", numberOfCoffees: coffees.count, cost: coffees.map(\.price).reduce(0, +), volume: coffees.map(\.volume).reduce(0, +))
                        .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text("Verlauf")
                            .padding(.bottom)
                        Chart(placeholderData) { day in
                            BarMark(
                                x: .value("Tag", day.date.formatted()),
                                y: .value("Ausgaben", day.cost))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.cremaCard)
                    .clipShape(.rect(cornerRadius: 15))
                }
                .padding(.top)
                .padding(.horizontal)
                .navigationTitle("Kaffee Tracker")
            }
            .scrollBounceBehavior(.basedOnSize)
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
    
    func currentWeeksCoffees() -> [Coffee] {
        coffees.filter { $0.date >= .now.startOfWeek ?? .now }
    }
}

#Preview {
    HomeView()
}

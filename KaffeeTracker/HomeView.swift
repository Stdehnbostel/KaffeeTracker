//
//  ContentView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import Charts
import SwiftData
import SwiftUI

struct CoffeeDay: Identifiable {
    var date: Date
    var cost: Double
    var id = UUID()
}

struct HomeView: View {
    static var descriptor: FetchDescriptor<CoffeeType> {
        var descriptor = FetchDescriptor<CoffeeType>(sortBy: [SortDescriptor(\.defaultPrice, order: .forward)])
        descriptor.fetchLimit = 1
        return descriptor
    }
    
    @Query(descriptor) var coffeeTypes: [CoffeeType]
    @Query(sort: \Coffee.date) var coffees: [Coffee]
    @State private var showNewCoffeSheet: Bool = false
    
    
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
                            .font(.title3)
                            .padding(.bottom)
                        Chart(chartData()) { day in
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
    
    func costForDayOfTheWeek(_ day: Int) -> Double {
        let start = Calendar.current.date(byAdding: .day, value: day, to: Date.now.startOfWeek ?? .now) ?? .now
        let end = Calendar.current.date(byAdding: .day, value: day + 1, to: Date.now.startOfWeek ?? .now) ?? .now
        return coffees.filter { $0.date >= start && $0.date < end }.map(\.price).reduce(0, +)
    }
    
    func chartData() -> [CoffeeDay] {
        var days = [CoffeeDay]()
        for day in 0..<7 {
            let start = Calendar.current.date(byAdding: .day, value: day, to: .now.startOfWeek ?? .now) ?? .now
            let end = Calendar.current.date(byAdding: .day, value: day + 1, to: .now.startOfWeek ?? .now) ?? .now
            let coffes = coffees.filter { $0.date >= start && $0.date < end }
            let prices = coffes.map(\.price)
            let cost = prices.reduce(0, +)
            days.append(CoffeeDay(date: start, cost: cost))
        }
        return days
    }
}

#Preview {
    HomeView()
}

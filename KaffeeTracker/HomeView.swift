//
//  ContentView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import Charts
import SwiftData
import SwiftUI

enum DiagramType: CaseIterable {
    case price, nrOFCoffees, caffeine
}

struct CoffeeDay: Identifiable {
    var date: Date
    var cost: Double
    var nrOfCoffees: Int
    var caffeine: Int
    var id = UUID()
    
    var formattedShortDate: String {
        date.formatted(.dateTime.day().month(.twoDigits))
    }
}

struct HomeView: View {
    static var descriptor: FetchDescriptor<CoffeeType> {
        var descriptor = FetchDescriptor<CoffeeType>(sortBy: [SortDescriptor(\.defaultPrice, order: .forward)])
        descriptor.fetchLimit = 1
        return descriptor
    }
    
    @Query(descriptor) var coffeeTypes: [CoffeeType]
    @Query(sort: \Coffee.date) var coffees: [Coffee]
    @State private var diagramType = DiagramType.price
    
    @State private var showNewCoffeSheet: Bool = false
    
    let diagramTypeNames: [DiagramType: String] = [.caffeine: "Koffein", .nrOFCoffees: "Anzahl", .price: "Preis"]
    let typeLabels: [DiagramType: String] = [.caffeine: "mg", .nrOFCoffees: "Stk", .price: "€"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CoffeeCardView(title: "Diese Woche", numberOfCoffees: currentWeeksCoffees().count, cost: currentWeeksCoffees().map(\.price).reduce(0, +), volume: currentWeeksCoffees().map(\.volume).reduce(0, +))
                        .padding(.bottom)
                    
                    CoffeeCardView(title: "Gesamt", numberOfCoffees: coffees.count, cost: coffees.map(\.price).reduce(0, +), volume: coffees.map(\.volume).reduce(0, +))
                        .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Verlauf")
                            Spacer()
                            Picker("Verlauf", selection: $diagramType) {
                                ForEach(DiagramType.allCases, id: \.self) {
                                    Text(diagramTypeNames[$0] ?? "").tag($0)
                                }
                            }
                        }
                        .padding(.bottom)
                        Chart(chartData()) { day in
                            switch diagramType {
                            case .price:
                                BarMark(
                                    x: .value("Tag", day.formattedShortDate),
                                    y: .value("Ausgaben", day.cost))
                            case .nrOFCoffees:
                                BarMark(
                                    x: .value("Tag", day.formattedShortDate),
                                    y: .value("Kaffees", day.nrOfCoffees))
                            case .caffeine:
                                BarMark(
                                    x: .value("Tag", day.formattedShortDate),
                                    y: .value("Koffein", day.caffeine))
                            }
                        }
                        .chartYAxisLabel(typeLabels[diagramType] ?? "")
                        .foregroundStyle(.cremaMid)
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
                    NavigationLink {
                        Settings()
                    } label: {
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
            let caffeinePortions = coffes.map(\.type.defaultCaffeine)
            let caffeine = caffeinePortions.reduce(0, +)
            let cost = prices.reduce(0, +)
            let nrOfCoffees = coffes.count
            days.append(CoffeeDay(date: start, cost: cost, nrOfCoffees: nrOfCoffees, caffeine: caffeine))
        }
        return days
    }
}

#Preview {
    HomeView()
}

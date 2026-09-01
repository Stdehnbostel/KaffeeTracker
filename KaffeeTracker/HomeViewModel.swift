//
//  HomeViewModel.swift
//  KaffeeTracker
//
//  Created by Stefan on 27.07.26.
//

import Foundation

extension HomeView {
    // enum to represent all available metrics for display in the chart.
    enum DiagramType: CaseIterable {
        case price, nrOFCoffees, caffeine
    }
    
    @Observable
    class ViewModel {
        /// The currently selected metric to show in the chart.
        var diagramType = DiagramType.price
        
        var showNewCoffeSheet: Bool = false
        
        /// maps the DiagramType names to localizeable string keys.
        let diagramTypeNames: [DiagramType: String] = [.caffeine: "Koffein", .nrOFCoffees: "Anzahl", .price: "Preis"]
        /// maps the DiagramType names to localizeable string keys for the chart labels.
        let typeLabels: [DiagramType: String] = [.caffeine: "mg", .nrOFCoffees: "Stk", .price: "€"]
        
        /// takes an array of Coffees and and returns an filtered array conataining only the coffees, that belong to the current week.
        func currentWeeksCoffees(for coffees: [Coffee]) -> [Coffee] {
            let now = Date.now
            let startOfWeek = now.startOfWeek ?? now
            let endOfWeek = Calendar.current.date(byAdding: .day, value: 7, to: startOfWeek) ?? now
            return coffees.filter { $0.date >= startOfWeek && $0.date < endOfWeek }
        }
        
        // takes an array of Coffees and returns the total cost for a given weekday.
        func costForDayOfTheWeek(for coffees: [Coffee], _ day: Int) -> Decimal {
            let start = Calendar.current.date(byAdding: .day, value: day, to: Date.now.startOfWeek ?? .now) ?? .now
            let end = Calendar.current.date(byAdding: .day, value: day + 1, to: Date.now.startOfWeek ?? .now) ?? .now
            return coffees.filter { $0.date >= start && $0.date < end }.map(\.price).reduce(0, +)
        }
        
        /// turns an array of Coffees into an array of CoffeeDays, that can be used for the chart.
        func chartData(for coffees: [Coffee]) -> [CoffeeDay] {
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
}

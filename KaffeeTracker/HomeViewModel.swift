//
//  HomeViewModel.swift
//  KaffeeTracker
//
//  Created by Stefan on 27.07.26.
//

import Foundation

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

extension HomeView {
    class ViewModel {
        var diagramType = DiagramType.price
        
        var showNewCoffeSheet: Bool = false
        
        let diagramTypeNames: [DiagramType: String] = [.caffeine: "Koffein", .nrOFCoffees: "Anzahl", .price: "Preis"]
        let typeLabels: [DiagramType: String] = [.caffeine: "mg", .nrOFCoffees: "Stk", .price: "€"]
        
        func currentWeeksCoffees(for coffees: [Coffee]) -> [Coffee] {
            coffees.filter { $0.date >= .now.startOfWeek ?? .now }
        }
        
        func costForDayOfTheWeek(for coffees: [Coffee], _ day: Int) -> Double {
            let start = Calendar.current.date(byAdding: .day, value: day, to: Date.now.startOfWeek ?? .now) ?? .now
            let end = Calendar.current.date(byAdding: .day, value: day + 1, to: Date.now.startOfWeek ?? .now) ?? .now
            return coffees.filter { $0.date >= start && $0.date < end }.map(\.price).reduce(0, +)
        }
        
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

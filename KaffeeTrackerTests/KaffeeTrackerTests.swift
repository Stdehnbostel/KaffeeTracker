//
//  KaffeeTrackerTests.swift
//  KaffeeTrackerTests
//
//  Created by Stefan on 27.07.26.
//

import Testing
import Foundation
@testable import KaffeeTracker

@MainActor
class HomeViewModelTests {
    let sut = HomeView.ViewModel()
    let type = CoffeeType(name: "Espresso", defaultVolume: 60, defaultPrice: 2.4, defaultCaffeine: 60)
    
    @Test func chartDataHasSevenDays() {
        let coffees = [Coffee]()
        #expect(sut.chartData(for: coffees).count == 7, "chartData should contain 7 elements")
    }
    
    @Test func chartDataHasCoffeeOnTheCorrectDay() {
        let coffee = Coffee(type: type, date: .now)
        let dayOfWeek = Calendar.current.component(.weekday, from: coffee.date)
        let startOfWeek = Calendar.current.component(.weekday, from: coffee.date.startOfWeek!)
        // add 7 because % ackts as a remainder operator in swift.
        // Adding 7 is sufficieant to solve this problem here, because there a only 7 days a week.
        let index = (dayOfWeek - startOfWeek + 7) % 7
        
        let sutData = sut.chartData(for: [coffee])
        
        #expect(sutData[index].nrOfCoffees == 1, "expected 1 coffee on day \(dayOfWeek), got \(sutData[index].nrOfCoffees)")
    }
    
    @Test func currentWeeksCoffeesReturnsTheCurrentWeeksCoffeesAndNotMore() {
        let startOfWeek = Date.now.startOfWeek!
        let coffeeAtStartOfWeek = Coffee(type: type, date: startOfWeek)
        let coffeeInTheCurrentWeek = Coffee(type: type, date: Calendar.current.date(byAdding: .second, value: 7 * 24 * 60 * 60 - 1, to: startOfWeek)!)
        let coffeeInTheLastWeek = Coffee(type: type, date: Calendar.current.date(byAdding: .second, value: -1, to: startOfWeek)!)
        let coffeeInTheNextWeek = Coffee(type: type, date: Calendar.current.date(byAdding: .day, value: 7, to: startOfWeek)!)
        
        let coffees = [coffeeInTheLastWeek, coffeeAtStartOfWeek, coffeeInTheCurrentWeek, coffeeInTheNextWeek]
        
        let currentWeeksCoffees = sut.currentWeeksCoffees(for: coffees)
        #expect(currentWeeksCoffees.count == 2, "expected 1 coffee to belong to the current week, got \(currentWeeksCoffees.count)")
        #expect(currentWeeksCoffees.first == coffeeAtStartOfWeek, "expected \(coffeeAtStartOfWeek) to be the first coffee in the result, got \(currentWeeksCoffees.first!)")
        #expect(currentWeeksCoffees.last == coffeeInTheCurrentWeek, "expected \(coffeeInTheCurrentWeek) to be the last coffee in the result, got \(currentWeeksCoffees.last!)")
    }
}

//
//  CoffeeTests.swift
//  KaffeeTrackerTests
//
//  Created by Stefan on 01.07.26.
//

import Foundation

import Testing
import Foundation
@testable import KaffeeTracker

struct CoffeeTests {
    let type = CoffeeType(name: "Flat White", defaultVolume: 120, defaultPrice: 4.80, defaultCaffeine: 60)
    @Test func convenienceInitCorrecltyInitializesCoffeeFromAType() {
        let date = Date.now
        let coffee = Coffee(type: type, date: .now)
        
        #expect(coffee.name == type.name, "The coffee's name should match the type's name")
        #expect(coffee.volume == type.defaultVolume, "The coffee's volume should match the type's default volume")
        #expect(coffee.price == type.defaultPrice, "The coffee's price should match the type's default price")
        #expect(coffee.type === type, "The coffee's type should be the one provided")
        #expect(coffee.date == date, "The coffee's date should match the provided date")
    }
}

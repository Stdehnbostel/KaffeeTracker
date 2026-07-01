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
    @Test func nameIsIdenticalToTypeName() {
        let type = CoffeeType(name: "Esspresso", defaultVolume: 60, defaultPrice: 2.4, defaultCaffeine: 60)
        let coffee = Coffee(price: 2.2, volume: 70, type: type, date: .now)
        #expect(type.name == coffee.type.name)
        #expect(type.name == coffee.name)
    }
}

//
//  Coffee.swift
//  KaffeeTracker
//
//  Created by Stefan on 24.06.26.
//

import Foundation
import SwiftData

@Model
class Coffee {
    var name: String
    var price: Double
    var volume: Int
    var type: CoffeeType
    var date: Date
    
    init(name: String, price: Double, volume: Int, type: CoffeeType, date: Date) {
        self.name = name
        self.price = price
        self.volume = volume
        self.type = type
        self.date = date
    }
}

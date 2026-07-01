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
    var type: CoffeeType
    var price: Double
    var volume: Int
    var date: Date
    
    init(price: Double, volume: Int, type: CoffeeType, date: Date) {
        self.price = price
        self.volume = volume
        self.type = type
        self.date = date
    }
    
    var name: String {
        type.name
    }
}

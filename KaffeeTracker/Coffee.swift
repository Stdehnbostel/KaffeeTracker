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
    var type: CoffeeType
    var price: Double
    var volume: Int
    var date: Date
    
    init(name: String, price: Double, volume: Int, type: CoffeeType, date: Date) {
        self.name = name
        self.price = price
        self.volume = volume
        self.type = type
        self.date = date
    }
    
    convenience init(type: CoffeeType, date: Date) {
        self.init(name: type.name, price: type.defaultPrice, volume: type.defaultVolume, type: type, date: date)
    }
}

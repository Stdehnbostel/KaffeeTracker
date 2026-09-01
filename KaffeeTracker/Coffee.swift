//
//  Coffee.swift
//  KaffeeTracker
//
//  Created by Stefan on 24.06.26.
//

import Foundation
import SwiftData

/// thr Coffee model represents individual coffees that have been registered in the app.
@Model
class Coffee {
    var name: String
    var type: CoffeeType
    var price: Decimal
    var volume: Int
    var date: Date
    
    init(name: String, price: Decimal, volume: Int, type: CoffeeType, date: Date) {
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

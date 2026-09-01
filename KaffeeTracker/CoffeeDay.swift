//
//  CoffeeDay.swift
//  KaffeeTracker
//
//  Created by Stefan on 01.09.26.
//

import Foundation

/// The CoffeeDay struct is a data model to reprensent one day in coffee for display in the chart. 
struct CoffeeDay: Identifiable {
    var date: Date
    var cost: Decimal
    var nrOfCoffees: Int
    var caffeine: Int
    var id = UUID()
    
    var formattedShortDate: String {
        date.formatted(.dateTime.day().month(.twoDigits))
    }
}

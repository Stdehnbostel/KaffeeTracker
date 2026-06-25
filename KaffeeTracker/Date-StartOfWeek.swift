//
//  Date-StartOfWeek.swift
//  KaffeeTracker
//
//  Created by Stefan on 25.06.26.
//

import Foundation

extension Date {
    var startOfWeek: Date? {
        Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
}

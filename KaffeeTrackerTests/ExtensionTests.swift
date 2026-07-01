//
//  ExtensionTests.swift
//  KaffeeTrackerTests
//
//  Created by Stefan on 25.06.26.
//

import Testing
import Foundation
@testable import KaffeeTracker

struct DateExtensionsTests {
    @Test func startOfWeekReturnsCorrectDate() {
        let formatter = ISO8601DateFormatter()
        // de summer time: 25.06.2026 12:00
        let date = formatter.date(from: "2026-06-25T10:00:00Z")!
        print(date.formatted())
        let expectedStartOfWeek = formatter.date(from: "2026-06-21T22:00:00Z")!
        
        let startOfWeek = date.startOfWeek
        #expect(startOfWeek == expectedStartOfWeek, "expected: 22.06.2026, 00:00, got: \(startOfWeek?.formatted())")
    }
    
    @Test func startOfWeekForMondayMidnightReturnsCorrectDate() {
        let formatter = ISO8601DateFormatter()
        // de summer time: 29.06.2026 00:00
        let date = formatter.date(from: "2026-06-28T22:00:00Z")!
        print(date.formatted())
        let expectedStartOfWeek = formatter.date(from: "2026-06-28T22:00:00Z")!
        
        let startOfWeek = date.startOfWeek
        #expect(startOfWeek == expectedStartOfWeek, "expected: 29.06.2026, 00:00, got: \(startOfWeek?.formatted())")
    }
}

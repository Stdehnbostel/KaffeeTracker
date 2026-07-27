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
    
    @Test func chartDataHasSevenDays() {
        let sut = HomeView.ViewModel()
        let coffees = [Coffee]()
        #expect(sut.chartData(for: coffees).count == 7, "chartData should contain 7 elements")
    }
}

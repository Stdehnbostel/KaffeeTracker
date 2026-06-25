//
//  CoffeeType.swift
//  KaffeeTracker
//
//  Created by Stefan on 17.06.26.
//

import Foundation
import SwiftData

@Model
class CoffeeType: Codable {
    enum CodingKeys: CodingKey {
        case name
        case defaultVolume
        case defaultPrice
        case defaultCaffeine
        case abbreviation
    }
    
    var name: String
    var defaultVolume: Int
    var defaultPrice: Double
    var defaultCaffeine: Int
    var abbreviation: String?
    var coffees = [Coffee]()
    
    init(name: String, defaultVolume: Int, defaultPrice: Double, defaultCaffeine: Int, abbreviation: String? = nil) {
        self.name = name
        self.defaultVolume = defaultVolume
        self.defaultPrice = defaultPrice
        self.defaultCaffeine = defaultCaffeine
        self.abbreviation = abbreviation
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        defaultVolume = try container.decode(Int.self, forKey: .defaultVolume)
        defaultPrice = try container.decode(Double.self, forKey: .defaultPrice)
        defaultCaffeine = try container.decode(Int.self, forKey: .defaultCaffeine)
        abbreviation = try container.decodeIfPresent(String.self, forKey: .abbreviation)
        print("Encoded abbreviation: \(String(describing: abbreviation))")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(defaultVolume, forKey: .defaultVolume)
        try container.encode(defaultPrice, forKey: .defaultPrice)
        try container.encode(defaultCaffeine, forKey: .defaultCaffeine)
        try container.encodeIfPresent(abbreviation, forKey: .abbreviation)
    }
}

//
//  CoffeeTypeView.swift
//  KaffeeTracker
//
//  Created by Stefan on 28.06.26.
//

import SwiftUI

struct CoffeeTypeView: View {
    @State private var name = ""
    @State private var defaultVolume = 0
    @State private var defaultPrice = 0.0
    @State private var defaultCaffeine = 0
    @State private var abbreviation = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                
                TextField("Abbreviation", text: $abbreviation)
            }
            
            Section {
                
                TextFieldWithUnit(unit: "ml", amount: $defaultVolume)
                
                TextField("Default Price", value: $defaultPrice, format: .currency(code: "EUR") )
                
                TextFieldWithUnit(unit: "mg", amount: $defaultCaffeine)
            }
        }
        .scrollContentBackground(.hidden)
        .background(.cremaBackground)
    }
}

#Preview {
    CoffeeTypeView()
}

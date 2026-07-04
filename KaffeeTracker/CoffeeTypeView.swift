//
//  CoffeeTypeView.swift
//  KaffeeTracker
//
//  Created by Stefan on 28.06.26.
//

import SwiftUI

struct CoffeeTypeView: View {
    @Bindable var type: CoffeeType
    @State private var name: String
    @State private var defaultVolume: Int
    @State private var defaultPrice: Double
    @State private var defaultCaffeine: Int
    @State private var abbreviation: String
    
    init(type: CoffeeType, name: String = "", defaultVolume: Int = 0, defaultPrice: Double = 0.0, defaultCaffeine: Int = 0, abbreviation: String = "") {
        self.type = type
        _name = State(initialValue: type.name)
        _defaultVolume = State(initialValue: type.defaultVolume)
        _defaultPrice = State(initialValue: type.defaultPrice)
        _defaultCaffeine = State(initialValue: type.defaultCaffeine)
        _abbreviation = State(initialValue: type.abbreviation ?? "")
    }
    
    var body: some View {
        VStack {
            CoffeeHeaderView(abbreviation: type.abbreviation ?? "", name: type.name)
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
                Section {
                    Button("Speichern", action: save)
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.cremaFoam)
                        .listRowBackground(Color(.cremaEspresso))
                }
            }
            .scrollContentBackground(.hidden)
        }
        .background(.cremaBackground)
        .navigationTitle("Sorte bearbeiten")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func save() {
        type.name = name
        type.defaultVolume = defaultVolume
        type.defaultPrice = defaultPrice
        type.defaultCaffeine = defaultCaffeine
        type.abbreviation = abbreviation != "" ? abbreviation : nil
    }
}

#Preview {
    CoffeeTypeView(type: CoffeeType(name: "Espresso", defaultVolume: 60, defaultPrice: 60, defaultCaffeine: 60, abbreviation: "ES"))
}

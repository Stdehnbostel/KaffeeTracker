//
//  CoffeeFormView.swift
//  KaffeeTracker
//
//  Created by Stefan on 29.06.26.
//

import SwiftUI

struct CoffeeFormView: View {
    @Binding var type: CoffeeType
    @Binding var price: Double
    @Binding var amount: Int
    @Binding var date: Date
    
    let coffeeTypes: [CoffeeType]
    
    var body: some View {
        Section {
                Picker("Sorte", selection: $type) {
                    ForEach(coffeeTypes, id: \.self) {
                        Text($0.name).tag($0)
                    }
                }
                .pickerStyle(.menu)
                .tint(.cremaEspresso)
            }
        Section {
            DatePicker("Zeit", selection: $date)
        }
            Section {
                HStack {
                    Text("Preis")
                    Spacer()
                    TextField("Preis", value: $price, format: .currency(code: "Eur"))
                        .frame(width: 80)
                }
                HStack {
                    Text("Menge")
                    Spacer()
                    TextFieldWithUnit(unit: "ml", amount: $amount)
                        .frame(width: 80)
                }
            }
    }
}

#Preview {
    struct Preview: View {
        @State private var coffee = Coffee(price: 2.4, volume: 60, type: CoffeeType(name: "Espresso", defaultVolume: 60, defaultPrice: 2.4, defaultCaffeine: 60), date: .now)
        var body: some View {
            CoffeeFormView(type: $coffee.type, price: $coffee.price, amount: $coffee.volume, date: $coffee.date, coffeeTypes: [])
        }
    }
    
    return Preview()
}

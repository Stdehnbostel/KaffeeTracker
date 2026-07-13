//
//  CoffeeTypeFormView.swift
//  KaffeeTracker
//
//  Created by Stefan on 13.07.26.
//

import SwiftUI

struct CoffeeTypeFormView: View {
    @Binding var name: String
    @Binding var abbreviation: String
    @Binding var defaultVolume: Int
    @Binding var defaultPrice: Double
    @Binding var defaultCaffeine: Int
    
    var body: some View {
        Section {
            HStack {
                Text("Bezeichnung")
                TextField("Bezeichnung", text: $name)
                    .multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Kürzel")
                TextField("Kürzel", text: $abbreviation)
                    .multilineTextAlignment(.trailing)
            }
        }
        Section {
            HStack {
                Text("Menge")
                TextFieldWithUnit(unit: "ml", amount: $defaultVolume)
                    .multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Preis")
                TextField("Standard Preis", value: $defaultPrice, format: .currency(code: "EUR") )
                    .multilineTextAlignment(.trailing)
            }
            HStack {
                Text("Koffeingehalt")
                TextFieldWithUnit(unit: "mg", amount: $defaultCaffeine)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var type = CoffeeType(name: "Espresso", defaultVolume: 60, defaultPrice: 2.4, defaultCaffeine: 60)
        @State private var abbreviation = "ES"
        var body: some View {
            CoffeeTypeFormView(name: $type.name, abbreviation: $abbreviation, defaultVolume: $type.defaultVolume, defaultPrice: $type.defaultPrice, defaultCaffeine: $type.defaultCaffeine)
        }
    }
    
    return Preview()
}

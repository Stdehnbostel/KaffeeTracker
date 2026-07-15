//
//  Settings.swift
//  KaffeeTracker
//
//  Created by Stefan on 14.07.26.
//

import SwiftUI

struct Settings: View {
    @State private var usePriceTarget = false
    @State private var priceTarget = 0.0
    @State private var useCaffeineTarget = false
    @State private var caffeineTarget = 0
    @State private var useCountTarget = false
    @State private var countTarget = 0
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Toggle("Ausgaben-Ziel setzen", isOn: $usePriceTarget)
                if usePriceTarget {
                    TextField("Ausgaben-Ziel", value: $priceTarget, format: .currency(code: "EUR"))
                }
            }
            VStack(alignment: .leading) {
                Toggle("Koffein-Ziel setzen", isOn: $useCaffeineTarget)
                if useCaffeineTarget {
                    TextFieldWithUnit(unit: "mg", amount: $caffeineTarget)
                }
            }
            VStack(alignment: .leading) {
                Toggle("Tassen-Ziel setzen", isOn: $useCountTarget)
                if useCountTarget {
                    TextField("Tassen-Ziel", value: $countTarget, format: .number)
                        .keyboardType(.numberPad)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Einstellungen")
        .background(Color(.cremaBackground))
    }
}

#Preview {
    Settings()
}

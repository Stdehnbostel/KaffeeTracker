//
//  Settings.swift
//  KaffeeTracker
//
//  Created by Stefan on 14.07.26.
//

import SwiftUI

struct Settings: View {
    @AppStorage("usePriceTarget") private var usePriceTarget = false
    @AppStorage("priceTarget") private var priceTarget = 0.0
    @AppStorage("useCaffeineTarget") private var useCaffeineTarget = false
    @AppStorage("caffeineTarget") private var caffeineTarget = 0
    @AppStorage("useCupTarget") private var useCupTarget = false
    @AppStorage("cupTarget") private var cupTarget = 0
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Toggle("Ausgaben-Ziel setzen", isOn: $usePriceTarget)
                if usePriceTarget {
                    HStack {
                        TextField("Ausgaben-Ziel", value: $priceTarget, format: .currency(code: "EUR"))
                            .focused($isFocused)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                        Stepper("Ausgaben-Ziel", value: $priceTarget)
                            .labelsHidden()
                    }
                }
            }
            VStack(alignment: .leading) {
                Toggle("Koffein-Ziel setzen", isOn: $useCaffeineTarget)
                if useCaffeineTarget {
                    HStack {
                        TextFieldWithUnit(unit: "mg", amount: $caffeineTarget)
                            .focused($isFocused)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                        Stepper("Koffein-Ziel", value: $caffeineTarget)
                            .labelsHidden()
                    }
                }
            }
            VStack(alignment: .leading) {
                Toggle("Tassen-Ziel setzen", isOn: $useCupTarget)
                if useCupTarget {
                    HStack {
                        TextField("Tassen-Ziel", value: $cupTarget, format: .number)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                            .multilineTextAlignment(.trailing)
                        Stepper("Tassen-Ziel", value: $cupTarget)
                            .labelsHidden()
                    }
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

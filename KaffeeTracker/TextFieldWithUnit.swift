//
//  VolumeTextField.swift
//  KaffeeTracker
//
//  Created by Stefan on 28.06.26.
//

import SwiftUI

struct TextFieldWithUnit: View {
    let unit: String
    @Binding var amount: Int
    
    var textField: some View {
        let text = Binding<String>(
            get: {
                amount > 0 ? "\(amount) \(unit)" : "0 \(unit)"
            }
            , set: { text in
                let text = text.replacingOccurrences(of: unit, with: "").trimmingCharacters(in: .whitespaces)
                print(text)
                let newAmount = Int(text) ?? 0
                print(newAmount)
                amount = newAmount
            }
        )
        
        return TextField("Menge", text: text)
            .keyboardType(.numberPad)
    }

    var body: some View {
        textField
    }
    
    }

#Preview {
    struct Preview: View {
        @State var volume: Int = 100
        
        var body: some View {
            TextFieldWithUnit(unit: "ml", amount: $volume)
        }
    }
    
    return Preview()
}

//
//  NewCoffeeView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import SwiftUI

struct NewCoffeeView: View {
    @Environment(\.dismiss) var dismiss
    let types = ["Espresso", "Cappucino", "Flat White", "Latte Macciato"]
    @State private var selectedType = "Espresso"
    @State private var price = 0.0
    @State private var volume = 0
    
    var textField: some View {
        let text = Binding<String>(
            get: {
                volume > 0 ? "\(volume) ml" : "0 ml"
            }
            , set: { text in
                let text = text.replacingOccurrences(of: "ml", with: "")
                let newVolume = Int(text) ?? 0
                volume = newVolume
            }
        )
        
        return TextField("Menge", text: text)
            .keyboardType(.numberPad)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    
                    Picker("Sorte", selection: $selectedType) {
                        ForEach(types, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.cremaEspresso)
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
                        textField
                            .frame(width: 80)
                    }
                }
                Button("Speichern") {
                    
                }
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .foregroundStyle(.cremaFoam)
                .listRowBackground(Color(.cremaEspresso))
            }
            .listSectionSpacing(.compact)
            .scrollContentBackground(.hidden)
            .background(.cremaBackground)
            .navigationTitle("Hinzufügen")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Schließen", systemImage: "xmark")
                    }
                }
            }
        }
    }
}

extension NewCoffeeView {
    class ViewModel {
        
        
    }
}

#Preview {
    NewCoffeeView()
}

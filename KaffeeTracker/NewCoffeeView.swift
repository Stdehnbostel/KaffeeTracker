//
//  NewCoffeeView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import SwiftData
import SwiftUI

struct NewCoffeeView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \CoffeeType.name) var types: [CoffeeType]
    @State private var selectedType: CoffeeType
    @State private var price: Double
    @State private var volume: Int
    
    init(defaultType: CoffeeType) {
        _selectedType = State(initialValue: defaultType)
        _price = State(initialValue: defaultType.defaultPrice)
        _volume = State(initialValue: defaultType.defaultVolume)
    }
    
    var textField: some View {
        let text = Binding<String>(
            get: {
                volume > 0 ? "\(volume) ml" : "0 ml"
            }
            , set: { text in
                let text = text.replacingOccurrences(of: "ml", with: "").trimmingCharacters(in: .whitespaces)
                print(text)
                let newVolume = Int(text) ?? 0
                print(newVolume)
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
                            Text($0.name).tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.cremaEspresso)
                    .onChange(of: selectedType) {
                        price = selectedType.defaultPrice
                        volume = selectedType.defaultVolume
                    }
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
                Button("Speichern", action: save)
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
    func save() {
        do {
            let coffee = Coffee(name: selectedType.name, price: price, volume: volume, type: selectedType, date: .now)
            modelContext.insert(coffee)
            try modelContext.save()
            dismiss()
        } catch {
            
        }
    }
}

extension NewCoffeeView {
    class ViewModel {
        
        
    }
}

#Preview {
    NewCoffeeView(defaultType: CoffeeType(name: "Espresse", defaultVolume: 60, defaultPrice: 2.4, defaultCaffeine: 60))
}

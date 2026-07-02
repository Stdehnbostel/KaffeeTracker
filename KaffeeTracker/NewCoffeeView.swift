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
    
    var body: some View {
        NavigationStack {
            VStack {
                CoffeeHeaderView(abbreviation: selectedType.abbreviation ?? "ES", name: selectedType.name)
                Form {
                    CoffeeFormView(type: $selectedType, price: $price, amount: $volume, coffeeTypes: types)
                        .tint(.cremaEspresso)
                        .onChange(of: selectedType) {
                            price = selectedType.defaultPrice
                            volume = selectedType.defaultVolume
                        }
                    Section {
                        Button("Speichern", action: save)
                    }
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.cremaFoam)
                    .listRowBackground(Color(.cremaEspresso))
                }
                .listSectionSpacing(.compact)
                .scrollContentBackground(.hidden)
            }
            .background(.cremaBackground)
            .navigationTitle("Hinzufügen")
            .navigationBarTitleDisplayMode(.inline)
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
            let coffee = Coffee(price: price, volume: volume, type: selectedType, date: .now)
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

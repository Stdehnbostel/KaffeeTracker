//
//  NewCoffeeView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import OSLog
import SwiftData
import SwiftUI

struct NewCoffeeView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \CoffeeType.name) var types: [CoffeeType]
    @State private var selectedType: CoffeeType
    @State private var name: String
    @State private var price: Double
    @State private var volume: Int
    @State private var date = Date.now
    
    @State private var showErrorAlert = false
    
    let logger = Logger(subsystem: "com.stdehnbostel.KaffeeTracker", category: "NewCoffeeView")
    
    init(defaultType: CoffeeType) {
        _selectedType = State(initialValue: defaultType)
        _price = State(initialValue: defaultType.defaultPrice)
        _volume = State(initialValue: defaultType.defaultVolume)
        _name = State(initialValue: defaultType.name)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CoffeeHeaderView(abbreviation: selectedType.abbreviation ?? "ES", name: selectedType.name)
                Form {
                    CoffeeFormView(type: $selectedType, name: $name, price: $price, amount: $volume, date: $date, coffeeTypes: types)
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
            .alert("Ein Fehler ist aufgetreten.", isPresented: $showErrorAlert) {
                Button("Ok") { }
            } message: {
                Text("Kaffee konnte nicht gespeichert werden. Versuche es später erneut.")
            }
        }
    }
    func save() {
        do {
            let coffee = Coffee(name: name, price: price, volume: volume, type: selectedType, date: date)
            modelContext.insert(coffee)
            try modelContext.save()
        } catch {
            showErrorAlert = true
            logger.error("Error saving CoffeeType: \(error.localizedDescription)")
        }
        dismiss()
    }
}

#Preview {
    NewCoffeeView(defaultType: CoffeeType(name: "Espresse", defaultVolume: 60, defaultPrice: 2.4, defaultCaffeine: 60))
}

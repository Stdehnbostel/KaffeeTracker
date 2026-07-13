//
//  KaffeeDetailView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import OSLog
import SwiftData
import SwiftUI

struct CoffeeDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Query(sort: \CoffeeType.defaultPrice) var coffeeTypes: [CoffeeType]
    @Environment(\.modelContext) private var modelContext
    @Bindable var coffee: Coffee
    @State private var type: CoffeeType
    @State private var name: String
    @State private var price: Double
    @State private var volume: Int
    @State private var date: Date
    
    @State private var showDeleteErrorAlert = false
    
    let logger = Logger(subsystem: "com.stdehnbostel.KaffeeTracker", category: "CoffeeDetailView")
    
    init(coffee: Coffee) {
        self.coffee = coffee
        _type = State(initialValue: coffee.type)
        _price = State(initialValue: coffee.price)
        _volume = State(initialValue: coffee.volume)
        _date = State(initialValue: coffee.date)
        _name = State(initialValue: coffee.name)
    }
    
    var body: some View {
        VStack {
            CoffeeHeaderView(abbreviation: coffee.type.abbreviation ?? "ES", name: coffee.type.name)
            Form {
                CoffeeFormView(type: $type, name: $name ,price: $price, amount: $volume, date: $date, coffeeTypes: coffeeTypes)
                Section {
                    Button("Speichern", action: save)
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.cremaFoam)
                        .listRowBackground(Color(.cremaEspresso))
                }
                Section {
                    Button("Löschen", action: delete)
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.cremaDanger)
                    .alert("Fehler beim Löschen", isPresented: $showDeleteErrorAlert) {
                        Button("Ok") {}
                    }
                }
            }
            .listSectionSpacing(.compact)
            .scrollContentBackground(.hidden)
            .navigationTitle("Bearbeiten")
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(.cremaBackground)
    }
    
    func save() {
        coffee.type = type
        coffee.price = price
        coffee.volume = volume
        dismiss()
    }
    
    func delete() {
        do {
            modelContext.delete(coffee)
            try modelContext.save()
        } catch {
            showDeleteErrorAlert = true
            logger.error("Error deleting coffee: \(error.localizedDescription)")
        }
        dismiss()
    }
}

#Preview {
    CoffeeDetailView(coffee: Coffee(type: CoffeeType(name: "Espresso", defaultVolume: 60, defaultPrice: 2.4, defaultCaffeine: 60), date: .now))
}

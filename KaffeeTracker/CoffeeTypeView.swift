//
//  CoffeeTypeView.swift
//  KaffeeTracker
//
//  Created by Stefan on 28.06.26.
//

import OSLog
import SwiftData
import SwiftUI

struct CoffeeTypeView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Bindable var type: CoffeeType
    @State private var name: String
    @State private var defaultVolume: Int
    @State private var defaultPrice: Double
    @State private var defaultCaffeine: Int
    @State private var abbreviation: String
    
    @State private var showDeleteErrorAlert = false
    
    let logger = Logger(subsystem: "com.stdehnbostel.KaffeeTracker", category: "CoffeeTypeView")
    
    init(type: CoffeeType, name: String = "", defaultVolume: Int = 0, defaultPrice: Double = 0.0, defaultCaffeine: Int = 0, abbreviation: String = "") {
        self.type = type
        _name = State(initialValue: type.name)
        _defaultVolume = State(initialValue: type.defaultVolume)
        _defaultPrice = State(initialValue: type.defaultPrice)
        _defaultCaffeine = State(initialValue: type.defaultCaffeine)
        _abbreviation = State(initialValue: type.abbreviation ?? "")
    }
    
    var body: some View {
        VStack {
            CoffeeHeaderView(abbreviation: type.abbreviation ?? "", name: type.name)
            Form {
                CoffeeTypeFormView(name: $name, abbreviation: $abbreviation, defaultVolume: $defaultVolume, defaultPrice: $defaultPrice, defaultCaffeine: $defaultCaffeine)
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
            .scrollContentBackground(.hidden)
            .listSectionSpacing(.compact)
        }
        .background(.cremaBackground)
        .navigationTitle("Sorte bearbeiten")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func save() {
        type.name = name
        type.defaultVolume = defaultVolume
        type.defaultPrice = defaultPrice
        type.defaultCaffeine = defaultCaffeine
        type.abbreviation = abbreviation != "" ? abbreviation : nil
    }
    
    func delete() {
        do {
            modelContext.delete(type)
            try modelContext.save()
        } catch {
            showDeleteErrorAlert = true
            logger.error("Error deleting coffee: \(error.localizedDescription)")
        }
        dismiss()
    }
}

#Preview {
    CoffeeTypeView(type: CoffeeType(name: "Espresso", defaultVolume: 60, defaultPrice: 60, defaultCaffeine: 60, abbreviation: "ES"))
}

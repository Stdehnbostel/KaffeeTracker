//
//  NewCoffeeTypeView.swift
//  KaffeeTracker
//
//  Created by Stefan on 13.07.26.
//

import OSLog
import SwiftData
import SwiftUI

struct NewCoffeeTypeView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name = "Name"
    @State private var defaultVolume = 0
    @State private var defaultPrice = 0.0
    @State private var defaultCaffeine = 0
    @State private var abbreviation = "NA"
    
    @State private var showErrorAlert = false
    
    let logger = Logger(subsystem: "com.stdehnbostel.KaffeeTracker", category: "NewCoffeeView")
    
    var body: some View {
        NavigationStack {
            Form {
                CoffeeTypeFormView(name: $name, abbreviation: $abbreviation, defaultVolume: $defaultVolume, defaultPrice: $defaultPrice, defaultCaffeine: $defaultCaffeine)
                Section {
                    Button("Speichern", action: save)
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.cremaFoam)
                        .listRowBackground(Color(.cremaEspresso))
                }
                .alert("Ein Fehler ist aufgetreten.", isPresented: $showErrorAlert) {
                    Button("Ok") { }
                } message: {
                    Text("Sorte konnte nicht gespeichert werden. Versuche es später erneut.")
                }
            }
        }
    }
    
    func save() {
        do {
            let type = CoffeeType(name: name, defaultVolume: defaultVolume, defaultPrice: defaultPrice, defaultCaffeine: defaultCaffeine, abbreviation: abbreviation)
            modelContext.insert(type)
            try modelContext.save()
        } catch {
            showErrorAlert = true
            logger.error("Error saving CoffeeType: \(error.localizedDescription)")
        }
        dismiss()
    }
}

#Preview {
    NewCoffeeTypeView()
}

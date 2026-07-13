//
//  NewCoffeeTypeView.swift
//  KaffeeTracker
//
//  Created by Stefan on 13.07.26.
//

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
    
    var body: some View {
        NavigationStack {
            Form {
                CoffeeTypeFormView(name: $name, abbreviation: $abbreviation, defaultVolume: $defaultVolume, defaultPrice: $defaultPrice, defaultCaffeine: $defaultCaffeine)
                Section {
                    Button("Speichern", action: save)
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
            
        }
        dismiss()
    }
}

#Preview {
    NewCoffeeTypeView()
}

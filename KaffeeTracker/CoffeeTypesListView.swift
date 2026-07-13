//
//  CoffeeTypesView.swift
//  KaffeeTracker
//
//  Created by Stefan on 28.06.26.
//

import SwiftData
import SwiftUI

struct CoffeeTypesListView: View {
    @Query(sort: \CoffeeType.name) var types: [CoffeeType]
    @State private var showNewCoffeeTypeSheet = false
    
    var body: some View {
        NavigationStack {
            List(types) { type in
                NavigationLink {
                    CoffeeTypeView(type: type)
                } label: {
                    HStack {
                        CoffeeIconView(abbreviation: type.abbreviation ?? "ES")
                            .frame(width: 64, height: 64)
                            .padding(.trailing, 4)
                        Text(type.name)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(.cremaBackground)
            .sheet(isPresented: $showNewCoffeeTypeSheet) {
                NewCoffeeTypeView()
            }
            .navigationTitle("Sorten")
            .toolbar {
                ToolbarItem {
                    Button {
                        showNewCoffeeTypeSheet = true
                    } label: {
                        Label("Hinzufügen", systemImage: "plus")
                    }
                }
            }
            
        }
    }
}

#Preview {
    CoffeeTypesListView()
}

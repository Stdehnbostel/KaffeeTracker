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
    
    var body: some View {
        NavigationStack {
            List(types) { type in
                NavigationLink {
                    CoffeeTypeView()
                } label: {
                    Text(type.name)
                }
            }
            .scrollContentBackground(.hidden)
            .background(.cremaBackground)
            .navigationTitle("Sorten")
            
        }
    }
}

#Preview {
    CoffeeTypesListView()
}

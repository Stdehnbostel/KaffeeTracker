//
//  ListView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import SwiftData
import SwiftUI

struct ListView: View {
    @Query(sort: \Coffee.date) var coffees: [Coffee]
    
    var body: some View {
        NavigationStack {
            List(coffees) { coffee in
                NavigationLink {
                    CoffeeDetailView()
                } label: {
                    HStack {
                        Text(coffee.type.abbreviation ?? "ES")
                            .font(.headline)
                            .foregroundStyle(.cremaInk)
                            .padding()
                            .background(.cremaFoam)
                            .clipShape(.rect(cornerRadius: 15))
                            .padding(.trailing, 4)
                        VStack {
                            HStack {
                                Text(coffee.name)
                                    .font(.body.bold())
                                Spacer()
                                Text(String(coffee.price))
                            }
                            HStack {
                                Text(coffee.date.formatted())
                                    .font(.caption)
                                Spacer()
                                Text("\(coffee.volume) ml 63 mg ")
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(.cremaBackground)
            .navigationTitle("Übersicht")
        }
    }
}

#Preview {
    ListView()
}

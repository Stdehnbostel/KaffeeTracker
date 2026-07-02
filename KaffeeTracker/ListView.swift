//
//  ListView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import SwiftData
import SwiftUI

struct ListView: View
{
    static var descriptor: FetchDescriptor<CoffeeType> {
        var descriptor = FetchDescriptor<CoffeeType>(sortBy: [SortDescriptor(\.defaultPrice, order: .forward)])
        descriptor.fetchLimit = 1
        return descriptor
    }
    
    @Query(descriptor) var coffeeTypes: [CoffeeType]
    @Query(sort: \Coffee.date) var coffees: [Coffee]
    @State private var showNewCoffeSheet = false
    
    var body: some View {
        NavigationStack {
            List(coffees) { coffee in
                NavigationLink(value: coffee) {
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
            .navigationDestination(for: Coffee.self) { coffee in
                CoffeeDetailView(coffee: coffee)
            }
            .scrollContentBackground(.hidden)
            .background(.cremaBackground)
            .navigationTitle("Verlauf")
            .toolbar {
                ToolbarItem {
                    Button {
                        showNewCoffeSheet = true
                    } label: {
                        Label("Hinzufügen", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showNewCoffeSheet) {
                if let defaultSelection = coffeeTypes.first {
                    NewCoffeeView(defaultType: defaultSelection)
                } else {
                    Text("Es können derzeit keine Kaffees hinzugefügt werden.")
                }
            }
        }
    }
}

#Preview {
    ListView()
}

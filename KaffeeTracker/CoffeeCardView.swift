//
//  CoffeeCardView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import SwiftUI

struct CoffeeCardView: View {
    let title: String
    let numberOfCoffees: Int
    let cost: Double
    let volume: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .padding(.bottom)
            Grid(alignment: .leading) {
                GridRow {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Kaffees")
                                .font(.caption)
                            Text(String(numberOfCoffees))
                                .font(.headline)
                        }
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Kosten")
                                .font(.caption)
                            Text(cost.formatted(.currency(code: "EUR")))
                                .font(.headline)
                        }
                        Spacer()
                    }
                }
                
                GridRow {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Menge")
                                .font(.caption)
                            Text("\(volume) ml")
                                .font(.headline)
                        }
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Koffein")
                                .font(.caption)
                            Text("416 mg")
                                .font(.headline)
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.cremaCard)
        .clipShape(.rect(cornerRadius: 15))
    }
}

#Preview {
    CoffeeCardView(title: "Diese Woche", numberOfCoffees: 5, cost: 15.40, volume: 610)
}

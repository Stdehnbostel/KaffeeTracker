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
                .padding(.bottom)
            Grid(alignment: .leading, verticalSpacing: 8) {
                GridRow {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "cup.and.heat.waves.fill")
                                Text("Kaffees")
                            }
                                .font(.caption)
                                .foregroundStyle(.cremaMid)
                            Text(String(numberOfCoffees))
                                .font(.title3.bold())
                        }
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "eurosign")
                                Text("Kosten")
                            }
                                .font(.caption)
                                .foregroundStyle(.cremaMid)
                            Text(cost.formatted(.currency(code: "EUR")))
                                .font(.title3.bold())
                        }
                        Spacer()
                    }
                }
                
                GridRow {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "drop")
                                Text("Menge")
                            }
                                .font(.caption)
                                .foregroundStyle(.cremaMid)
                            Text("\(volume) ml")
                                .font(.title3.bold())
                        }
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "bolt")
                                Text("Koffein")
                            }
                                .font(.caption)
                                .foregroundStyle(.cremaMid)
                            Text("416 mg")
                                .font(.title3.bold())
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

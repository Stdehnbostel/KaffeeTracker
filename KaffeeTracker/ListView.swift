//
//  ListView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    CoffeeDetailView()
                } label: {
                    HStack {
                        Text("ES")
                            .font(.headline)
                            .foregroundStyle(.cremaInk)
                            .padding()
                            .background(.cremaFoam)
                            .clipShape(.rect(cornerRadius: 15))
                            .padding(.trailing, 4)
                        VStack {
                            HStack {
                                Text("Espresso")
                                    .font(.body.bold())
                                Spacer()
                                Text("2,40€")
                            }
                            HStack {
                                Text("05.06.2026 9:00")
                                    .font(.caption)
                                Spacer()
                                Text("30 ml 63 mg ")
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

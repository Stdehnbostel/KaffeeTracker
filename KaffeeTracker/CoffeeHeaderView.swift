//
//  CoffeeHeaderView.swift
//  KaffeeTracker
//
//  Created by Stefan on 02.07.26.
//

import SwiftUI

struct CoffeeHeaderView: View {
    let abbreviation: String
    let name: String
    
    var body: some View {
        Text(abbreviation)
            .font(.title2)
            .padding(20)
            .background(.cremaFoam)
            .clipShape(.rect(cornerRadius: 15))
        Text(name)
            .font(.title.bold())
    }
}

#Preview {
    CoffeeHeaderView(abbreviation: "ES", name: "Espresso")
}

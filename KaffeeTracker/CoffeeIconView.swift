//
//  CoffeeIconView.swift
//  KaffeeTracker
//
//  Created by Stefan on 05.07.26.
//

import SwiftUI

struct CoffeeIconView: View {
    let abbreviation: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.cremaFoam)
                .aspectRatio(1.0, contentMode: .fit)
            Text(abbreviation)
                .font(.title2.bold())
                .foregroundStyle(.cremaInk)
        }
    }
}

#Preview {
    CoffeeIconView(abbreviation: "ES")
}

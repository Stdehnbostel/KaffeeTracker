//
//  ContentView.swift
//  KaffeeTracker
//
//  Created by Stefan on 11.06.26.
//

import Charts
import SwiftData
import SwiftUI

struct HomeView: View {
    static var descriptor: FetchDescriptor<CoffeeType> {
        var descriptor = FetchDescriptor<CoffeeType>(sortBy: [SortDescriptor(\.defaultPrice, order: .forward)])
        descriptor.fetchLimit = 1
        return descriptor
    }
    
    @Query(descriptor) var coffeeTypes: [CoffeeType]
    @Query(sort: \Coffee.date) var coffees: [Coffee]
    
    @State private var viewModel = ViewModel()
    
    @AppStorage(SettingsKey.usePriceTarget) private var usePriceTarget = false
    @AppStorage(SettingsKey.priceTarget) private var priceTarget = 0
    @AppStorage(SettingsKey.useCaffeineTarget) private var useCaffeineTarget = false
    @AppStorage(SettingsKey.caffeineTarget) private var caffeineTarget = 0
    @AppStorage(SettingsKey.useCupTarget) private var useCupTarget = false
    @AppStorage(SettingsKey.cupTarget) private var cupTarget = 0
   
    let strokeStyle = StrokeStyle(lineWidth: 2, dash: [5.0])
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    let weekly = viewModel.currentWeeksCoffees(for: coffees)
                    CoffeeCardView(title: "Diese Woche", numberOfCoffees: weekly.count, cost: weekly.map(\.price).reduce(0, +), volume: weekly.map(\.volume).reduce(0, +))
                        .padding(.bottom)
                    
                    CoffeeCardView(title: "Gesamt", numberOfCoffees: coffees.count, cost: coffees.map(\.price).reduce(0, +), volume: coffees.map(\.volume).reduce(0, +))
                        .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Verlauf")
                            Spacer()
                            Picker("Verlauf", selection: $viewModel.diagramType) {
                                ForEach(DiagramType.allCases, id: \.self) {
                                    Text(viewModel.diagramTypeNames[$0] ?? "").tag($0)
                                }
                            }
                        }
                        .padding(.bottom)
                        Chart {
                            ForEach(viewModel.chartData(for: coffees)) { day in
                                switch viewModel.diagramType {
                                case .price:
                                    BarMark(
                                        x: .value("Tag", day.formattedShortDate),
                                        y: .value("Ausgaben", day.cost))
                                case .nrOFCoffees:
                                    BarMark(
                                        x: .value("Tag", day.formattedShortDate),
                                        y: .value("Kaffees", day.nrOfCoffees))
                                case .caffeine:
                                    BarMark(
                                        x: .value("Tag", day.formattedShortDate),
                                        y: .value("Koffein", day.caffeine))
                                }
                            }
                            switch viewModel.diagramType {
                            case .price:
                                if usePriceTarget {
                                    RuleMark(
                                        y: .value("Ziel", priceTarget))
                                    .foregroundStyle(.cremaDanger)
                                    .lineStyle(strokeStyle)
                                }
                            case .nrOFCoffees:
                                if useCupTarget {
                                    RuleMark(
                                        y: .value("Ziel", cupTarget))
                                    .foregroundStyle(.cremaDanger)
                                    .lineStyle(strokeStyle)
                                }
                            case .caffeine:
                                if useCaffeineTarget {
                                    RuleMark(
                                        y: .value("Ziel", caffeineTarget))
                                    .foregroundStyle(.cremaDanger)
                                    .lineStyle(strokeStyle)
                                }
                            }
                            
                        }
                        .chartYAxisLabel(viewModel.typeLabels[viewModel.diagramType] ?? "")
                        .foregroundStyle(.cremaMid)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.cremaCard)
                    .clipShape(.rect(cornerRadius: 15))
                }
                .padding(.top)
                .padding(.horizontal)
                .navigationTitle("Kaffee Tracker")
            }
            .scrollBounceBehavior(.basedOnSize)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button {
                        viewModel.showNewCoffeSheet = true
                    } label: {
                        Label("Hinzufügen", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        Settings()
                    } label: {
                        Label("Einstellungen", systemImage: "gear")
                    }
                }
            }
            .background(.cremaBackground)
            .sheet(isPresented: $viewModel.showNewCoffeSheet) {
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
    HomeView()
}

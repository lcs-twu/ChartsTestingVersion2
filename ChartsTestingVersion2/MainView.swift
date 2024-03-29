//
//  MainView.swift
//  ChartsTestingVersion2
//
//  Created by Tom Wu on 2024-01-17.
//

import SwiftUI
import Charts

private var coffeeSales = [
    (name: "Americano", count: 120),
    (name: "Cappuccino", count: 234),
    (name: "Espresso", count: 62),
    (name: "Latte", count: 625),
    (name: "Mocha", count: 320),
    (name: "Affogato", count: 50)
]

private func findSelectedSector(value: Int) -> String? {

    var accumulatedCount = 0

    let coffee = coffeeSales.first { (_, count) in
        accumulatedCount += count
        return value <= accumulatedCount
    }

    return coffee?.name
}

struct MainView: View {
    @State private var selectedCount: Int?
    @State private var selectedSector: String?
    var body: some View {
        //        Chart {
        //            ForEach(coffeeSales, id: \.name) { coffee in
        //
        //                SectorMark(
        //                    angle: .value("Cup", coffee.count),
        //                    outerRadius: coffee.name == "Latte" ? 150:120,
        //                    angularInset: 2.0
        //                )
        //                .annotation(position: .overlay) {
        //                    Text("\(coffee.count)")
        //                        .font(.headline)
        //                        .foregroundStyle(.white)
        //                }
        //                .foregroundStyle(by: .value("Type", coffee.name))
        //            }
        //        }
        //        .frame(height: 500)
        Chart {
            ForEach(coffeeSales, id: \.name) { coffee in
                SectorMark(
                    angle: .value("Cup", coffee.count),
                    innerRadius: .ratio(0.65),
                    angularInset: 2.0
                )
                .opacity(selectedSector == nil ? 1.0 : (selectedSector == coffee.name ? 1.0 : 0.5))
                .foregroundStyle(by: .value("Type", coffee.name))
                .cornerRadius(10.0)
                                .annotation(position: .overlay) {
                                    Text("\(coffee.count)")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
            }
        }
        .frame(height: 500)
        .chartAngleSelection(value: $selectedCount)
        .onChange(of: selectedCount) { oldValue, newValue in
            if let newValue {
                selectedSector = findSelectedSector(value: newValue)
            } else {
                selectedSector = nil
            }
        }
    }
}

#Preview {
    MainView()
}

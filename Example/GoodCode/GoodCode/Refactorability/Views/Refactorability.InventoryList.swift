//
//  Refactorability.InventoryList.swift
//  GoodCode
//
//  Created by Matheus Gois on 09/07/24.
//

import SwiftUI

extension Refactorability {
    struct InventoryList: View {

        @EnvironmentObject var centralState: CentralState
        @ObservedObject private var currencyConverter = CurrencyConverter()

        var body: some View {
            VStack {
                Title()

                Refactorability.Inventory(currencyConverter: currencyConverter)

                Spacer()

                NextButton()
            }
        }

        func Title() -> some View {
            Text("Inventory")
                .font(.title)
                .padding()
        }

        func NextButton() -> some View {
            Section {
                Text("Total in cart \(centralState.cart.count)")
                    .font(.headline)
                    .padding()
            }
        }
    }
}

struct Refactorability_InventoryList_Preview: PreviewProvider {
    static var previews: some View {
        Refactorability.InventoryList()
            .environmentObject(Refactorability.CentralState.mock)
    }
}


//
//  Inventory.swift
//  GoodCode
//
//  Created by Matheus Gois on 08/07/24.
//

import SwiftUI

extension Reusability {
    struct InventoryList: View {

        @State private var inventory = [
            InventoryItem(
                id: 0,
                product: "Flashlight",
                image: "placeholder",
                description: "A really great flashlight",
                price: 100,
                currency: .usd
            ),
            InventoryItem(
                id: 1,
                product: "Tin can",
                image: "placeholder",
                description: "Pretty much what you would expect from a tin can",
                price: 32,
                currency: .usd
            ),
            InventoryItem(
                id: 2,
                product: "Cardboard Box",
                image: "placeholder",
                description: "It holds things",
                price: 5,
                currency: .usd
            )
        ]

        @ObservedObject private var currencyConverter = CurrencyConverter()

        var body: some View {
            VStack(alignment: .leading) {
                Title()

                CurrencySelector(selectedCurrency: $currencyConverter.localCurrency)

                Inventory(inventory: inventory, currencyConverter: currencyConverter)
            }
        }

        func Title() -> some View {
            Text("Inventory")
                .font(.title)
                .padding()
        }
    }
}

struct Reusability_InventoryList_Preview: PreviewProvider {
    static var previews: some View {
        Reusability.InventoryList()
    }
}

//
//  Inventory.swift
//  GoodCode
//
//  Created by Matheus Gois on 09/07/24.
//

import SwiftUI

extension Reusability {
    struct Inventory: View {

        @State private var inventory: [InventoryItem]
        @ObservedObject private var currencyConverter: CurrencyConverter

        init(inventory: [InventoryItem], currencyConverter: CurrencyConverter) {
            self.inventory = inventory
            self.currencyConverter = currencyConverter
        }

        var body: some View {
            List(inventory) { item in
                HStack {
                    Image(item.image)
                        .resizable()
                        .frame(width: 50, height: 50)

                    VStack(alignment: .leading) {
                        Text(item.product)
                            .font(.headline)
                        Text(item.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Text(
                        currencyConverter.convert(
                            price: item.price,
                            fromCurrency: item.currency
                        )
                    )
                    .font(.headline)
                    .foregroundColor(.blue)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct Reusability_Inventory_Preview: PreviewProvider {
    static var previews: some View {
        Reusability.Inventory(
            inventory: [
                .init(
                    id: 0,
                    product: "Flashlight",
                    image: "placeholder",
                    description: "A really great flashlight",
                    price: 100,
                    currency: .usd
                ),
                .init(
                    id: 1,
                    product: "Tin can",
                    image: "placeholder",
                    description: "Pretty much what you would expect from a tin can",
                    price: 32,
                    currency: .usd
                ),
                .init(
                    id: 2,
                    product: "Cardboard Box",
                    image: "placeholder",
                    description: "It holds things",
                    price: 5,
                    currency: .usd
                )
            ],
            currencyConverter: Reusability.CurrencyConverter()
        )
    }
}

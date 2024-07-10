//
//  InventoryView.swift
//  GoodCode
//
//  Created by Matheus Gois on 08/07/24.
//

import SwiftUI

extension Readability {
    struct InventoryView: View {

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

        var body: some View {
            List {
                ForEach(inventory) { item in
                    HStack {
                        Image(item.image)
                            .resizable()
                            .frame(width: 50, height: 50)

                        VStack(alignment: .leading) {
                            Text(item.product)
                                .font(.headline)
                            Text(item.description)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(item.priceFormatted)
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }

    struct InventoryItem: Identifiable {
        var id: Int
        var product: String
        var image: String
        var description: String
        var price: Int
        var currency: Reusability.Currency

        var priceFormatted: String {
            "\(currency.symbol) \(price)"
        }
    }
}

struct Readability_InventoryView_Preview: PreviewProvider {
    static var previews: some View {
        Readability.InventoryView()
    }
}

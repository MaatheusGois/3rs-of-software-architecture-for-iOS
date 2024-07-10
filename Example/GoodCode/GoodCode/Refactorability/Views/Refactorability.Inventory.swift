//
//  Refactorability.Inventory.swift
//  GoodCode
//
//  Created by Matheus Gois on 09/07/24.
//

import SwiftUI

extension Refactorability {
    struct Inventory: View {

        @ObservedObject private var currencyConverter: CurrencyConverter
        @EnvironmentObject var centralState: CentralState

        init(currencyConverter: CurrencyConverter) {
            self.currencyConverter = currencyConverter
        }

        var body: some View {
            List(centralState.inventory) { item in
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


                    Button(action: {
                        centralState.addToCart(item: item)
                    }) {
                        Text("Add")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct Refactorability_Inventory_Preview: PreviewProvider {
    static var previews: some View {
        Refactorability.Inventory(
            currencyConverter: Reusability.CurrencyConverter()
        )
        .environmentObject(Refactorability.CentralState.mock)
    }
}

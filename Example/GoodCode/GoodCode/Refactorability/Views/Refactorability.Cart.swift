//
//  Refactorability.Cart.swift
//  GoodCode
//
//  Created by Matheus Gois on 09/07/24.
//

import SwiftUI

extension Refactorability {
    struct Cart: View {
        @EnvironmentObject var centralState: CentralState
        private var currencyConverter = CurrencyConverter()

        var body: some View {
            VStack {
                Text("Cart")
                    .font(.largeTitle)

                if centralState.cart.isEmpty {
                    Text("Nothing in the cart")
                } else {
                    List(centralState.cart) { item in
                        HStack {
                            Text(item.product)
                            Spacer()
                            Text(convertedPrice(for: item))
                        }
                    }
                }
            }
        }

        func convertedPrice(for item: InventoryItem) -> String {
            return currencyConverter.convert(price: item.price, fromCurrency: item.currency)
        }
    }
}


//
//  Cart.swift
//  BadCode
//
//  Created by Matheus Gois on 09/07/24.
//

import SwiftUI

struct Cart: View {
    @State private var cart: [InventoryItem]

    private var currencyConverter: CurrencyConverter
    @State private var timer: Timer?

    init(
        currencyConverter: CurrencyConverter
    ) {
        self.cart = GlobalState.shared.cart
        self.currencyConverter = currencyConverter
    }

    var body: some View {
        VStack {
            Text("Cart")
                .font(.largeTitle)

            if cart.isEmpty {
                Text("Nothing in the cart")
            } else {
                List(cart) { item in
                    HStack {
                        Text(item.product)
                        Spacer()
                        Text(
                            currencyConverter.convertCurrency(
                                price: item.price,
                                fromCurrency: item.currency
                            )
                        )
                    }
                }
            }
        }
        .onAppear {
            // Mock
            GlobalState.shared.cart = [
                .init(
                    id: 0,
                    product: "Flashlight",
                    image: "placeholder",
                    description: "A really great flashlight",
                    price: 100,
                    currency: .usd
                )
            ]
            startWatchingCart()
        }
        .onDisappear {
            stopWatchingCart()
        }
    }

    func startWatchingCart() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            cart = GlobalState.shared.cart
        }
    }

    func stopWatchingCart() {
        timer?.invalidate()
    }
}

struct preview_Cart: PreviewProvider {

    static var previews: some View {
        Cart(
            currencyConverter: CurrencyConverter()
        )
    }
}

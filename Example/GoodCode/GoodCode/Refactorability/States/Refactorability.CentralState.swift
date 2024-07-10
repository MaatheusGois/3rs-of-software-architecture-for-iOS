//
//  CentralState.swift
//  GoodCode
//
//  Created by Matheus Gois on 09/07/24.
//

import SwiftUI

extension Refactorability {
    class CentralState: ObservableObject {
        static let shared = CentralState()

        @Published var cart: [InventoryItem] = []
        @Published var inventory: [InventoryItem] = []
        @Published var localCurrency: Currency = .usd

        func addToCart(item: InventoryItem) {
            cart.append(item)
        }

        func setInventory(items: [InventoryItem]) {
            inventory = items
        }

        func setLocalCurrency(currency: Currency) {
            localCurrency = currency
        }
    }
}

extension Refactorability.CentralState {
    static var mock: Refactorability.CentralState {
        let mockState = Refactorability.CentralState()
        mockState.setInventory(
            items: [
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
            ]
        )

        return mockState
    }
}

//
//  Tests.swift
//  Tests
//
//  Created by Matheus Gois on 09/07/24.
//

import XCTest
@testable import GoodCode

class CentralStateTests: XCTestCase {
    let centralState = Refactorability.CentralState.mock

    func testAddToCart() {
        let item = Readability.InventoryItem(
            id: 0,
            product: "Flashlight",
            image: "placeholder",
            description: "A really great flashlight",
            price: 100,
            currency: .usd
        )

        centralState.addToCart(item: item)
        XCTAssertEqual(centralState.cart.count, 1)
        XCTAssertEqual(centralState.cart.first, item)
    }

    func testSetInventory() {
        let items = [
            Readability.InventoryItem(
                id: 0,
                product: "Flashlight",
                image: "placeholder",
                description: "A really great flashlight",
                price: 100,
                currency: .usd
            ),
            Readability.InventoryItem(
                id: 1,
                product: "Tin can",
                image: "placeholder",
                description: "Pretty much what you would expect from a tin can",
                price: 32,
                currency: .usd
            ),
            Readability.InventoryItem(
                id: 2,
                product: "Cardboard Box",
                image: "placeholder",
                description: "It holds things",
                price: 5,
                currency: .usd
            )
        ]
        centralState.setInventory(items: items)
        XCTAssertEqual(centralState.inventory, items)
    }

    func testSetLocalCurrency() {
        let currency = Readability.Currency.usd
        centralState.setLocalCurrency(currency: currency)
        XCTAssertEqual(centralState.localCurrency, currency)
    }
}

extension Readability.InventoryItem: Equatable {
    public static func == (lhs: Readability.InventoryItem, rhs: Readability.InventoryItem) -> Bool {
        lhs.id == rhs.id
    }
}

//
//  Reusability.InventoryItem.swift
//  GoodCode
//
//  Created by Matheus Gois on 09/07/24.
//

import SwiftUI

extension Reusability {
    struct InventoryItem: Identifiable {
        var id: Int
        var product: String
        var image: String
        var description: String
        var price: Int
        var currency: Currency

        var priceFormatted: String {
            "\(currency.symbol) \(price)"
        }
    }
}

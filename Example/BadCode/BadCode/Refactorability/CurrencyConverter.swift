//
//  CurrencyConverter.swift
//  BadCode
//
//  Created by Matheus Gois on 09/07/24.
//

import SwiftUI

class CurrencyConverter: ObservableObject {
    @Published var localCurrency = Currency.usd

    private let currencyConversions: [Currency: [Currency: Double]] = [
        .usd: [.usd: 1.0, .rupee: 66.78, .yuan: 6.87],
        .rupee: [.usd: 1/66.78, .rupee: 1.0, .yuan: 0.107],
        .yuan: [.usd: 1/6.87, .rupee: 9.35, .yuan: 1.0]
    ]

    func convertCurrency(
        price: Int,
        fromCurrency: Currency
    ) -> String {
        let convertedAmount = Double(price) * currencyConversions[fromCurrency]![localCurrency]!
        return "\(localCurrency.symbol)\(String(format: "%.2f", convertedAmount))"
    }
}

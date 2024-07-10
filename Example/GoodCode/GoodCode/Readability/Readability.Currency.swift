//
//  Readability.Currency.swift
//  GoodCode
//
//  Created by Matheus Gois on 09/07/24.
//

import Foundation

extension Readability {
    enum Currency: CaseIterable {
        case usd
        case rupee
        case yuan

        var name: String {
            switch self {
            case .usd:
                return "USD"
            case .rupee:
                return "Rupee"
            case .yuan:
                return "Yuan"
            }
        }

        var symbol: String {
            switch self {
            case .usd:
                return "$"
            case .rupee:
                return "₹"
            case .yuan:
                return "元"
            }
        }
    }
}

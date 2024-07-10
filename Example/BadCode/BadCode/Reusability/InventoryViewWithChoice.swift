//
//  InventoryView.swift
//  BadCode
//
//  Created by Matheus Gois on 08/07/24.
//

import SwiftUI

struct InventoryViewWithChoice: View {

    @State private var localCurrency = Currency.usd

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

    private let currencyConversions: [Currency: [Currency: Double]] = [
        .usd: [.usd: 1.0, .rupee: 66.78, .yuan: 6.87],
        .rupee: [.usd: 1/66.78, .rupee: 1.0, .yuan: 0.107],
        .yuan: [.usd: 1/6.87, .rupee: 9.35, .yuan: 1.0]
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Inventory")
                .font(.title)
                .padding()
            Picker("Currency", selection: $localCurrency) {
                ForEach(Currency.allCases, id: \.self) { currency in
                    Text(currency.name).tag(currency)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

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
                        convertCurrency(
                            price: item.price,
                            fromCurrency: item.currency,
                            toCurrency: localCurrency
                        )
                    )
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .listStyle(PlainListStyle())
        }
    }

    private func convertCurrency(
        price: Int,
        fromCurrency: Currency,
        toCurrency: Currency
    ) -> String {
        let convertedAmount = Double(price) * currencyConversions[fromCurrency]![toCurrency]!
        return "\(toCurrency.symbol)\(String(format: "%.2f", convertedAmount))"
    }
}

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

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryViewWithChoice()
    }
}

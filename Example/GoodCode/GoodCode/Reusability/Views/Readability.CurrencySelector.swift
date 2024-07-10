//
//  CurrencySelector.swift
//  GoodCode
//
//  Created by Matheus Gois on 09/07/24.
//

import SwiftUI

extension Reusability {
    struct CurrencySelector: View {
        @Binding var selectedCurrency: Currency

        var body: some View {
            Picker("Currency", selection: $selectedCurrency) {
                ForEach(Currency.allCases, id: \.self) { currency in
                    Text(currency.name).tag(currency)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
    }
}

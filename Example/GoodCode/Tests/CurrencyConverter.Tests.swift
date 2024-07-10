//
//  CurrencyConverter.Tests.swift
//  Tests
//
//  Created by Matheus Gois on 09/07/24.
//

import XCTest
@testable import GoodCode

class CurrencyConverterTests: XCTestCase {
    func testConvert() {
        let converter = Reusability.CurrencyConverter()
        converter.localCurrency = .usd

        // Test conversion from USD to Rupee
        let usdToRupee = converter.convert(price: 100, fromCurrency: .usd)
        XCTAssertEqual(usdToRupee, "$100.00")

        // Test conversion from Rupee to Yuan
        let rupeeToYuan = converter.convert(price: 500, fromCurrency: .rupee)
        XCTAssertEqual(rupeeToYuan, "$7.49")

        // Test conversion from Yuan to USD
        let yuanToUsd = converter.convert(price: 1000, fromCurrency: .yuan)
        XCTAssertEqual(yuanToUsd, "$145.56")
    }
}

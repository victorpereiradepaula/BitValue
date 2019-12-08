//
//  PriceDBTests.swift
//  BitValueTests
//
//  Created by Victor Pereira de Paula on 08/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import XCTest
@testable import BitValue

class PriceDBTests: XCTestCase {

    func testMap() {
        let prices = [
            Price(unixTimestamp: 1234, value: 999),
            Price(unixTimestamp: 4321, value: 4444)
        ]
        let marketPrices = MarketPrices(unit: "USD", prices: prices)
        
        let pricesDB = PriceDB.map(marketPrices: marketPrices)
        
        XCTAssert(pricesDB.count == marketPrices.prices.count)
        
        let unit = marketPrices.unit
        
        let firstPriceDB = pricesDB[0]
        let firstPrice = marketPrices.prices[0]
        
        XCTAssert(firstPriceDB.unixTimestampString == String(format: "%.0f", firstPrice.unixTimestamp))
        XCTAssert(firstPriceDB.unixTimestamp == firstPrice.unixTimestamp)
        XCTAssert(firstPriceDB.value == firstPrice.value)
        XCTAssert(firstPriceDB.unit == unit)
        
        let secondPriceDB = pricesDB[1]
        let secondPrice = marketPrices.prices[1]
        
        XCTAssert(secondPriceDB.unixTimestampString == String(format: "%.0f", secondPrice.unixTimestamp))
        XCTAssert(secondPriceDB.unixTimestamp == secondPrice.unixTimestamp)
        XCTAssert(secondPriceDB.value == secondPrice.value)
        XCTAssert(secondPriceDB.unit == unit)
    }
}

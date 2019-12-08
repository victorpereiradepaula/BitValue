//
//  PriceViewModelTests.swift
//  BitValueTests
//
//  Created by Victor Pereira de Paula on 08/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import XCTest
@testable import BitValue

class PriceViewModelTests: XCTestCase {

    func testMap() {
        let priceDB = PriceDB()
        priceDB.unixTimestampString = "1234"
        priceDB.unixTimestamp = 1234
        priceDB.unit = "USD"
        priceDB.value = 11111
        
        let priceViewModels = PriceViewModel.mapArray(pricesDB: [priceDB])
        
        let firstPriceViewModel = priceViewModels[0]
        
        XCTAssert(priceDB.unixTimestampString == String(format: "%.0f", firstPriceViewModel.date.timeIntervalSince1970))
        XCTAssert(priceDB.unixTimestamp == firstPriceViewModel.date.timeIntervalSince1970)
        XCTAssert(priceDB.value == firstPriceViewModel.value)
        XCTAssert(priceDB.unit == firstPriceViewModel.unit)
    }
}

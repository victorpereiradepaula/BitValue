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
        let firstPriceDB = PriceDB()
        firstPriceDB.unixTimestampString = "1234"
        firstPriceDB.unixTimestamp = 1234
        firstPriceDB.unit = "USD"
        firstPriceDB.value = 11111
        
        let secondPriceDB = PriceDB()
        secondPriceDB.unixTimestampString = "565"
        secondPriceDB.unixTimestamp = 565
        secondPriceDB.unit = "USD"
        secondPriceDB.value = 4329991
        
        let priceViewModels = PriceViewModel.map(pricesDB: [firstPriceDB, secondPriceDB])
        
        let firstPriceViewModel = priceViewModels[0]
        
        print(firstPriceDB.unixTimestampString)
        print(String(format: "%.0f", firstPriceViewModel.date.timeIntervalSince1970))
        
        XCTAssert(firstPriceDB.unixTimestampString == String(format: "%.0f", firstPriceViewModel.date.timeIntervalSince1970))
        XCTAssert(firstPriceDB.unixTimestamp == firstPriceViewModel.date.timeIntervalSince1970)
        XCTAssert(firstPriceDB.value == firstPriceViewModel.value)
        XCTAssert(firstPriceDB.unit == firstPriceViewModel.unit)
        
        let secondPriceViewModel = priceViewModels[1]
        
        XCTAssert(secondPriceDB.unixTimestampString == String(format: "%.0f",secondPriceViewModel.date.timeIntervalSince1970))
        XCTAssert(secondPriceDB.unixTimestamp == secondPriceViewModel.date.timeIntervalSince1970)
        XCTAssert(secondPriceDB.value == secondPriceViewModel.value)
        XCTAssert(secondPriceDB.unit == secondPriceViewModel.unit)
    }
}

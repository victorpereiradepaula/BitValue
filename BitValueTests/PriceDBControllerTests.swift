//
//  PriceDBControllerTests.swift
//  BitValueTests
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import XCTest
import RealmSwift
@testable import BitValue

class PriceDBControllerTests: XCTestCase {

    private lazy var realmInMemory: Realm = {
       var configuration = Realm.Configuration()
       configuration.inMemoryIdentifier = self.name
       return try! Realm(configuration: configuration)
    }()
    
    override func setUp() {
        try! realmInMemory.write {
           realmInMemory.deleteAll()
        }
    }

    func testAddPriceDB() {
        let priceDB = PriceDB()
        priceDB.unixTimestampString = "4556"
        priceDB.unit = "USD"
        priceDB.value = 2.5
        priceDB.unixTimestamp = 4556
        
        let priceDBController = PriceDBController(realm: realmInMemory)
        
        do {
            try priceDBController.addPricesDB(pricesDB: [priceDB])
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        let price = priceDBController.getPricesDB()
        
        XCTAssert(price.count == 1)
        
        guard let firstPrice = price.first else {
            XCTFail("Falha ao obter o objeto")
            return
        }
        
        XCTAssert(firstPrice.unixTimestampString == priceDB.unixTimestampString)
        XCTAssert(firstPrice.unit == priceDB.unit)
        XCTAssert(firstPrice.value == priceDB.value)
        XCTAssert(firstPrice.unixTimestamp == priceDB.unixTimestamp)
    }
}

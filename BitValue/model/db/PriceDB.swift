//
//  PriceDB.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import RealmSwift

final class PriceDB: Object {
    
    // Realm just accept Int or String as primary key
    @objc dynamic var unixTimestampString: String = ""
    
    @objc dynamic var unit: String = ""
    @objc dynamic var unixTimestamp: Double = 0
    @objc dynamic var value: Double = 0
    
    override static func primaryKey() -> String? {
        return "unixTimestampString"
    }
}

// MARK: - Map MarketPrices
extension PriceDB {
    
    static func map(marketPrices: MarketPrices) -> [PriceDB] {
        var pricesDB: [PriceDB] = []
        let unit = marketPrices.unit
        
        for price in marketPrices.prices {
            let priceDB = PriceDB()
            priceDB.unixTimestampString = String(format: "%.0f", price.unixTimestamp)
            priceDB.unixTimestamp = price.unixTimestamp
            priceDB.value = price.value
            priceDB.unit = unit
            
            pricesDB.append(priceDB)
        }
        
        return pricesDB
    }
}

//
//  MarketPrices.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

struct MarketPrices: Codable {
    let unit: String
    let prices: [Price]
    
    enum CodingKeys: String, CodingKey {
        case unit
        case prices = "values"
    }
}

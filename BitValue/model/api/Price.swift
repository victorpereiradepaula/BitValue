//
//  Price.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

struct Price: Codable {
    let unixTimestamp: Double
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case unixTimestamp = "x"
        case value = "y"
    }
}

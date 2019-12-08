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

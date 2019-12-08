//
//  PriceDBController.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import RealmSwift

final class PriceDBController {
    let realm: Realm
    
    init(realm: Realm) {
       self.realm = realm
    }
    
    convenience init() {
        self.init(realm: try! Realm())
    }
    
    func addPricesDB(pricesDB: [PriceDB]) throws {
        try realm.write {
            self.realm.add(pricesDB, update: .modified)
        }
    }
    
    func getPricesDB() -> [PriceDB] {
        Array(realm.objects(PriceDB.self))
    }
}

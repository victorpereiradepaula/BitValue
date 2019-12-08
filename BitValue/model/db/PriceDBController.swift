//
//  PriceDBController.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import RealmSwift

final class PriceDBController {
    
    private let realm: Realm
    
    init(realm: Realm) {
       self.realm = realm
    }
    
    convenience init() {
        self.init(realm: try! Realm())
    }
    
    func addPricesDB(pricesDB: [PriceDB], completion: (() -> Void)) throws {
        try removeAllPricesDB()
        try realm.write {
            self.realm.add(pricesDB, update: .modified)
        }
        completion()
    }
    
    func getPricesDB() -> [PriceDB] {
        Array(realm.objects(PriceDB.self))
    }
    
    private func removeAllPricesDB() throws {
        try realm.write {
            self.realm.deleteAll()
        }
    }
}

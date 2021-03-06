//
//  PriceViewModel.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 05/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import Foundation

final class PriceViewModel {
    
    let date: Date
    let value: Double
    let unit: String
    
    /**
        Initializes a PriceViewModel, this implements `HighlightedPriceViewModelProtocol`, `PriceChartViewModelProtocol` and `PriceViewModelProtocol`
     
        - Parameters:
            - date: Date
            - value: Double
            - unit: String ("USD" by default)

        - Returns: PriceViewModel
     */
    init(date: Date, value: Double, unit: String = "USD") {
        self.date = date
        self.value = value
        self.unit = unit
    }
    
    /**
        Initializes a PriceViewModel with PriceDB, this implements `HighlightedPriceViewModelProtocol`, `PriceChartViewModelProtocol` and `PriceViewModelProtocol`

        - Parameters:
            - priceDB: PriceDB

        - Returns: PriceViewModel
     */
    init(priceDB: PriceDB) {
        self.date = Date(timeIntervalSince1970: priceDB.unixTimestamp)
        self.unit = priceDB.unit
        self.value = priceDB.value
    }
}

extension PriceViewModel: HighlightedPriceViewModelProtocol {
    
    var completeDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd MMM yyyy HH:mm"
        
        return dateFormatter.string(from: date)
    }
}

extension PriceViewModel: PriceChartViewModelProtocol {
    
    var timeInterval: TimeInterval {
        date.timeIntervalSince1970
    }
}

extension PriceViewModel: PriceViewModelProtocol {
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    var valueString: String {
        String(format: "%.2f", value)
    }
}

// MARK: - DB maps
extension PriceViewModel {
    
    private static func map(priceDB: PriceDB) -> PriceViewModel {
        let date = Date(timeIntervalSince1970: priceDB.unixTimestamp)
        return PriceViewModel(date: date, value: priceDB.value, unit: priceDB.unit)
    }
    
    static func mapArray(pricesDB: [PriceDB]) -> [PriceViewModel] {
        pricesDB.compactMap { map(priceDB: $0) }
    }
}

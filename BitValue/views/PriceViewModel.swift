//
//  PriceViewModel.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 05/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import Foundation

class PriceViewModel {
    
    private let date: Date
    private let value: Double
    let unit: String
    
    init(date: Date, value: Double, unit: String = "USD") {
        self.date = date
        self.value = value
        self.unit = unit
    }
}

extension PriceViewModel: PriceViewModelProtocol, HighlightedPriceViewModelProtocol {
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    var valueString: String {
        String(format: "%.2f", value)
    }
}

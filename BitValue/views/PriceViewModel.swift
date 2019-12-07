//
//  PriceViewModel.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 05/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import Foundation

final class PriceViewModel {
    
    private let date: Date
    let value: Double
    let unit: String
    
    init(date: Date, value: Double, unit: String = "USD") {
        self.date = date
        self.value = value
        self.unit = unit
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

//
//  MarketPricesViewModel.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import Foundation

final class MarketPricesViewModel {
    
    var sections: [[PriceViewModel]] = []
    
    init(pricesViewModels: [PriceViewModel]) {
        let sortedViewModels: [PriceViewModel] = pricesViewModels.sorted(by: { $0.date < $1.date})
        
        if let highlitedPrice = sortedViewModels.first {
            sections.append([highlitedPrice])
            sections.append(sortedViewModels)
        }
       
        if sortedViewModels.count > 1 {
            sections.append(Array(sortedViewModels.dropFirst()))
        }
    }
}

extension MarketPricesViewModel: MarketPricesTableViewControllerProtocol {
    
    var numberOfSections: Int {
        sections.count
    }
    
    func headerTitle(at section: Int) -> String? {
        switch section {
        case 0:
            return "Última cotação"
            
        case 1:
            return "Evolução da cotação"
            
        case 2:
            return "Cotações anteriores (USD)"
            
        default:
            return nil
        }
    }
    
    func numberOfRows(at section: Int) -> Int {
        switch section {
        case 1:
            return 1
            
        default:
            return sections[section].count
        }
    }
}

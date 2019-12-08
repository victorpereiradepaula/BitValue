//
//  MarketPricesViewModel.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MarketPricesViewModel {
    
    private let priceDBController = PriceDBController()
    private let reloadDataSubject = PublishSubject<Void>()
    private let alertSubject = PublishSubject<AlertViewModelProtocol?>()
    var sections: [[PriceViewModel]] = []
    
    init() {
        loadSectionsFromDB()
    }
    
    private func loadSectionsFromDB() {
        sections = []
        
        let pricesViewModels = PriceViewModel.map(pricesDB: priceDBController.getPricesDB())
        
        let sortedViewModels = pricesViewModels.sorted(by: { $0.date < $1.date})
        
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
    
    var reloadDataDriver: Driver<Void> {
        reloadDataSubject.asDriver(onErrorJustReturn: ())
    }
    
    var alertDriver: Driver<AlertViewModelProtocol?> {
        alertSubject.asDriver(onErrorJustReturn: nil)
    }
    
    var numberOfSections: Int {
        sections.count
    }
    
    func refreshData() {
        do {
            try priceDBController.addPricesDB(pricesDB: PriceDB.map(marketPrices: MarketPrices(unit: "USD", prices: [
                Price(unixTimestamp: 1544054400, value: 7656.995),
                Price(unixTimestamp: 1544400000, value: 7360.544166666667),
                Price(unixTimestamp: 1544745600, value: 7307.416666666668),
                Price(unixTimestamp: 1545091200, value: 7314.758333333335),
                Price(unixTimestamp: 1545436800, value: 7288.243333333335)
            ])))
        } catch {
            print(error.localizedDescription)
        }
        
        reloadDataSubject.onNext(())
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

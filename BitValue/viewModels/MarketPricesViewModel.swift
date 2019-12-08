//
//  MarketPricesViewModel.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import Foundation
import Combine
import RxSwift
import RxCocoa

final class MarketPricesViewModel {
    
    private let marketPricesAPI = MarketPricesAPI()
    private let viewStateSubject = BehaviorSubject<ViewState>(value: .default)
    private let reloadDataSubject = PublishSubject<Void>()
    private let alertSubject = PublishSubject<AlertViewModelProtocol?>()
    var sections: [[PriceViewModel]] = []
    
    init() {
        refreshData()
    }
    
    private func loadSectionsFromDB() {
        let priceDBController = PriceDBController()
        sections = []
        
        let pricesViewModels = PriceViewModel.mapArray(pricesDB: priceDBController.getPricesDB())
        
        let sortedViewModels = Array(pricesViewModels.reversed())
        
        if let highlitedPrice = sortedViewModels.first {
            sections.append([highlitedPrice])
            
            // Graph needs values in crescent order
            sections.append(pricesViewModels)
        }
        
        if sortedViewModels.count > 1 {
            sections.append(Array(sortedViewModels.dropFirst()))
        }
        
        reloadDataSubject.onNext(())
    }
    
    private func saveOnDB(marketPrices: MarketPrices) {
        let priceDBController = PriceDBController()
        do {
            try priceDBController.addPricesDB(pricesDB: PriceDB.map(marketPrices: marketPrices), completion: { [weak self] () in
                self?.loadSectionsFromDB()
            })
        } catch {
            alertSubject.onNext(AlertViewModel(title: "Falha ao salvar novos dados", message: error.localizedDescription))
            loadSectionsFromDB()
        }
    }
}

extension MarketPricesViewModel: MarketPricesTableViewControllerProtocol {
    
    var viewStateDriver: Driver<ViewState> {
        viewStateSubject.asDriver(onErrorJustReturn: .default)
    }
    
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
        viewStateSubject.onNext(.loading)
        
        _ = marketPricesAPI.getMarketPrices()
            .catch({ [weak self] (error) -> AnyPublisher<MarketPrices, Never> in
                self?.alertSubject.onNext(AlertViewModel(title: "Falha ao obter novos dados", message: error.localizedDescription))
                self?.loadSectionsFromDB()
                self?.viewStateSubject.onNext(.default)
                return [].publisher
                    .eraseToAnyPublisher()
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (marketPrices) in
                self?.saveOnDB(marketPrices: marketPrices)
                self?.viewStateSubject.onNext(.default)
            })
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

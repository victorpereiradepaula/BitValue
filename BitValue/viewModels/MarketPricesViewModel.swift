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
    private let priceDBController = PriceDBController()
    private let viewStateSubject = BehaviorSubject<ViewState>(value: .default)
    private let reloadDataSubject = PublishSubject<Void>()
    private let alertSubject = PublishSubject<AlertViewModelProtocol?>()
    var sections: [[PriceViewModel]] = []
    
    init() {
        refreshData()
    }
    
    private func loadSectionsFromDB() {
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
                self?.alertSubject.onNext(AlertViewModel(title: "Falha ao obter novos dados", message: error.localizedDescription, alertActions: []))
                self?.loadSectionsFromDB()
                self?.viewStateSubject.onNext(.default)
                return [].publisher
                    .eraseToAnyPublisher()
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (marketPrices) in
                print(marketPrices)
                do {
                    try self?.priceDBController.addPricesDB(pricesDB: PriceDB.map(marketPrices: marketPrices))
                } catch {
                    self?.alertSubject.onNext(AlertViewModel(title: "Falha ao salvar novos dados", message: error.localizedDescription, alertActions: []))
                }
                self?.loadSectionsFromDB()
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

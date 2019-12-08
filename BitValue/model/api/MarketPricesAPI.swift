//
//  MarketPricesAPI.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 08/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import Foundation
import Combine

final class MarketPricesAPI {
    
    func getMarketPrices() -> AnyPublisher<MarketPrices, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://api.blockchain.info/charts/market-price?timespan=1week&format=json")!)
            .mapObject(MarketPrices.self)
            .eraseToAnyPublisher()
    }
}

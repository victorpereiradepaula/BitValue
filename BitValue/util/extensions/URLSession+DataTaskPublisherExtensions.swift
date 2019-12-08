//
//  URLSession+DataTaskPublisherExtensions.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 08/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import Foundation
import Combine

extension URLSession.DataTaskPublisher {
    
    func mapObject<T: Codable>(_ type: T.Type, jsonDecoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> {
        return map {
            return $0.data
        }
        .decode(type: T.self, decoder: jsonDecoder)
        .eraseToAnyPublisher()
    }
}

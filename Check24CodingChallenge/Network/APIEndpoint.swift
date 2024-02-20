//
//  APIEndpoint.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation

enum APIEndpoint {
    case products
    case simulateBrokenURL
}

extension APIEndpoint {
    
    var baseURL: URL {
        URL(string: "http://app.check24.de/")!
    }
    
    var path: String {
        switch self {
        case .products:
            "products-test.json"
        case .simulateBrokenURL:
            "simulate_network_error" // random URL which breaks the network request
        }
    }
}

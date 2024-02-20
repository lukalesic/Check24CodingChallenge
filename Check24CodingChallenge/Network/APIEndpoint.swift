//
//  APIEndpoint.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation

enum APIEndpoint {
    case products
}

extension APIEndpoint {
    
    var baseURL: URL {
        URL(string: "http://app.check24.de/")!
    }
    
    static let footerLink = "http://m.check24.de/rechtliche-hinweise?deviceoutput=app"
    
    var path: String {
        switch self {
        case .products:
            "products-test.json"
        }
    }
}

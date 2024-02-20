//
//  Price.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation

struct Price: Codable {
    let value: Double
    let currency: Currency
}

enum Currency: String, Codable {
    case eur = "EUR"
}

//
//  BaseResponse.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation

struct BaseResponse: Codable {
    let header: Header
    let filters: [String]
    let products: [Product]
}

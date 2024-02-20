//
//  DataState.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation

enum DataState {
    case empty
    case loading
    case error(error: Error)
    case populated
}

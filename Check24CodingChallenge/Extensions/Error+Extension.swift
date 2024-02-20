//
//  Error+Extension.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation

enum NetworkError: Error {
    case noConnection
    case invalidServerResponse
    case notFound
    case unexpectedStatusCode(Int)
    case cannotDecodeData
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noConnection:
            return NSLocalizedString("No Internet connection available.", comment: "")
        case .invalidServerResponse:
            return NSLocalizedString("Invalid server response.", comment: "")
        case .unexpectedStatusCode(_):
            return NSLocalizedString("Unexpected status code", comment: "")
        case .notFound:
            return NSLocalizedString("404 endpoint not found!", comment: "")
        case .cannotDecodeData:
            return NSLocalizedString("Cannot decode data at the moment", comment: "")
        }
    }
}

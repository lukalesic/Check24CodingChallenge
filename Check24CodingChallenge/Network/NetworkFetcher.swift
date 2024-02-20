//
//  NetworkFetcher.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation
import SwiftUI

class NetworkFetcher: ObservableObject {
    let decoder = JSONDecoder()
    @ObservedObject private var networkMonitor = NetworkMonitor()

    func createURL(for url: APIEndpoint, path: String) -> URL {
        let baseURL = url.baseURL
        let urlString = baseURL.appendingPathComponent(path)
        return urlString
    }
    
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        
        guard networkMonitor.isConnected else {
            throw NetworkError.noConnection
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidServerResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            if (httpResponse.statusCode == 404) {
                throw NetworkError.notFound
            } else {
                throw NetworkError.unexpectedStatusCode(httpResponse.statusCode)
            }
        }
        
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print(error)
            throw NetworkError.cannotDecodeData
        }
    }
}

//
//  FavouritesManager.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation

class FavouritesManager: ObservableObject {

    static let shared = FavouritesManager()
    private let keyID = "favourites_array_key"
    
    @Published var favourites: [Int] {
        didSet {
            updateFavourites()
        }
    }

    private init() {
        if let localFavourites = UserDefaults.standard.array(forKey: keyID) as? [Int] {
            self.favourites = localFavourites
        } else {
            self.favourites = []
        }
    }

    private func updateFavourites() {
        UserDefaults.standard.set(favourites, forKey: keyID)
    }

    func addToFavourites(_ id: Int) {
         if !favourites.contains(id) {
            objectWillChange.send()
            favourites.append(id)
         }
    }

    func contains(_ id: Int) -> Bool {
        return favourites.contains(id)
    }

    func removeFromFavourites(_ id: Int) {
        if let index = favourites.firstIndex(of: id) {
            objectWillChange.send()
            favourites.remove(at: index)
        }
    }
}

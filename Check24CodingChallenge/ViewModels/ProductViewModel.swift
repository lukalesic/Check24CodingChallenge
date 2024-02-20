//
//  ProductViewModel.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation

class ProductViewModel: ObservableObject, Identifiable {
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var id: Int {
        product.id
    }
    
    var name: String {
        product.name
    }
    
    var isAvailable: Bool {
        product.available
    }
    
    var shortDescription: String {
        product.description
    }
    
    var longDescription: String {
        product.longDescription
    }
    
    var rating: Double {
        product.rating
    }
    
    var imageString: String {
        product.imageURL
    }
    
    func toggleFavouriteState() {
        objectWillChange.send()
        
        if FavouritesManager.shared.contains(product.id) {
            removeFromFavourites()
        }
        else {
            addToFavourites()
        }
    }
    
    private func addToFavourites() {
        FavouritesManager.shared.addToFavourites(product.id)
    }
    
    private func removeFromFavourites() {
        FavouritesManager.shared.removeFromFavourites(product.id)
    }
    
    func isFavourite() -> Bool {
        FavouritesManager.shared.contains(product.id)
    }
    
    func formatDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(product.releaseDate))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        
        return formatter.string(from: date)
    }
    
    func formatPrice() -> String {
        let price = product.price.value
        let currency = product.price.currency.rawValue
        
        return String(format: "Preis: \(price) " + currency)
    }
}

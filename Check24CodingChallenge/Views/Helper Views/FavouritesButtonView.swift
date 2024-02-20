//
//  FavouritesButtonView.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import SwiftUI

struct FavouritesButtonView: View {
    @ObservedObject private(set) var productViewModel: ProductViewModel
    @State private var buttonText: String = ""
    
    init(_ productViewmodel: ProductViewModel) {
        self.productViewModel = productViewmodel
    }
    
    var body: some View {
        Button {
            productViewModel.toggleFavouriteState()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(productViewModel.isFavourite() ? Color.favouritesColor : .orange)
                .brightness(productViewModel.isFavourite() ? -0.2 : 0)
                .overlay (
                    Text(productViewModel.isFavourite() ? "Vergessen" : "Vormerken")
                        .foregroundColor(.white)
                )
        }
        .frame(width: 320, height: 50)
    }
}

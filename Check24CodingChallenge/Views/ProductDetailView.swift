//
//  ProductDetailView.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var productViewModel: ProductViewModel
    @State private var isPresentingWebLink = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack(spacing: 10) {
                    ProductImageView(productViewModel, width: 100, height: 100)
                    VStack(alignment: .leading) {
                        productName()
                        productPrice()
                        HStack {
                            productRating()
                            productDate()
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                productShortDescription()
                    .lineLimit(3)
                favouritesButton()
                productLongDescription()
                footerTextView()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .sheet(isPresented: $isPresentingWebLink) {
                        FooterWebpageView(isPresentingWebLink: $isPresentingWebLink)
                    }
            }
            .padding(.all)
        }
    }
}

private extension ProductDetailView {
    
    @ViewBuilder
    func productName() -> some View {
        Text(productViewModel.product.name)
            .font(.headline)
    }
    
    @ViewBuilder
    func productRating() -> some View {
        ProductRatingView(productViewModel, width: 17, height: 17)
    }
    
    @ViewBuilder
    func productPrice() -> some View {
        Text(productViewModel.formatPrice())
            .foregroundStyle(.secondary)
    }
    
    @ViewBuilder
    func productDate() -> some View {
        Text(productViewModel.formatDate())
    }
    
    @ViewBuilder
    func productShortDescription() -> some View {
        Text(productViewModel.shortDescription)
            .lineLimit(3)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    @ViewBuilder
    func productLongDescription() -> some View {
        Text(productViewModel.longDescription)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func favouritesButton() -> some View {
        FavouritesButtonView(productViewModel)
    }
    
    @ViewBuilder
    func footerTextView() -> some View {
        FooterTextView(isPresentingWebLink: $isPresentingWebLink)
    }
}

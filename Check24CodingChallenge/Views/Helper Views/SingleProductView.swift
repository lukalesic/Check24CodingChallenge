//
//  SingleProductView.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import SwiftUI

struct SingleProductView: View {
    @ObservedObject private(set) var productViewModel: ProductViewModel
    
    init(_ productViewModel: ProductViewModel) {
        self.productViewModel = productViewModel
    }
    
    var body: some View {
        HStack {
            if productViewModel.isAvailable {
                ProductImageView(productViewModel)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    productName()
                    if (productViewModel.isAvailable) {
                        Spacer()
                        productDate()
                    }
                }
                productDescription()
                
                HStack() {
                    if (productViewModel.isAvailable) {
                        productPrice()
                        Spacer()
                    }
                    
                    ProductRatingView(productViewModel)
                }
            }
            if !productViewModel.isAvailable {
                Spacer()
                ProductImageView(productViewModel)
            }
        }
    }
}

private extension SingleProductView {
    
    @ViewBuilder
    func productName() -> some View {
        Text(productViewModel.name)
            .font(.system(size: 14, weight: .bold))
            .lineLimit(2)
            .minimumScaleFactor(0.85)
    }
    
    @ViewBuilder
    func productDate() -> some View {
        Text(productViewModel.formatDate())
            .font(.footnote)
    }
    
    @ViewBuilder
    func productDescription() -> some View {
        Text(productViewModel.shortDescription)
            .font(.system(size: 12))
            .lineLimit(2)
    }
    
    @ViewBuilder
    func productPrice() -> some View {
        Text(productViewModel.formatPrice())
            .font(.system(size: 12))
            .foregroundStyle(.secondary)
    }
    
}

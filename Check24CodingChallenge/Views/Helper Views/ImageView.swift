//
//  ImageView.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import SwiftUI

struct ProductImageView: View {
    @ObservedObject private var productViewModel: ProductViewModel
    private let width: CGFloat
    private let height: CGFloat
    
    init(_ productViewModel: ProductViewModel, width: CGFloat = 70, height: CGFloat = 70) {
        self.productViewModel = productViewModel
        self.width = width
        self.height = height
    }
    
    var body: some View {
        AsyncImage(url: URL(string: productViewModel.imageString)) { image in
            image
                .resizable()
                .frame(width: width, height: height)
                .cornerRadius(6)
        } placeholder: {
            Rectangle()
                .foregroundStyle(.gray)
                .frame(width: width, height: height)
        }
    }
}

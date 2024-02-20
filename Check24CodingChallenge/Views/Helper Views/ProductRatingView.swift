//
//  ProductRatingView.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import SwiftUI

struct ProductRatingView: View {
   @ObservedObject private var productViewModel: ProductViewModel
    private let ratingValue: Double
    private let fullStars: Int
    private let halfStar: Int
    private let width: CGFloat
    private let height: CGFloat
    
    init(_ productViewModel: ProductViewModel, width: CGFloat = 11, height: CGFloat = 11) {
        self.productViewModel = productViewModel
        ratingValue = productViewModel.rating
        fullStars = Int(ratingValue)
        halfStar = ratingValue - Double(fullStars) >= 0.5 ? 1 : 0
        self.width = width
        self.height = height
    }

    var body: some View {
        HStack(spacing: 1) {
            ForEach(1...fullStars, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: width, height: height)
            }
            if halfStar == 1 {
                Image(systemName: "star.leadinghalf.fill")
                    .resizable()
                    .frame(width: width, height: height)
            }
            ForEach(0..<(5 - fullStars - halfStar), id: \.self) { _ in
                Image(systemName: "star")
                    .resizable()
                    .frame(width: width, height: height)
            }
        }
        .foregroundColor(.orange)
    }
}

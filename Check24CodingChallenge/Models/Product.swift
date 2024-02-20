//
//  Produc t.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation

struct Product: Codable {
    let name: String
    let type: TypeEnum
    let id: Int
    let color: ProductColor
    let imageURL: String
    let colorCode: ColorCode
    let available: Bool
    let releaseDate: Int
    let description, longDescription: String
    let rating: Double
    let price: Price
}

enum ProductColor: String, Codable {
    case blue = "Blue"
    case green = "Green"
    case red = "Red"
    case yellow = "Yellow"
}

enum ColorCode: String, Codable {
    case bbdefb = "BBDEFB"
    case c8E6C9 = "C8E6C9"
    case ffCDD2 = "ffCDD2"
    case ffecb3 = "FFECB3"
}

enum TypeEnum: String, Codable {
    case circle = "Circle"
    case hexagon = "Hexagon"
    case square = "Square"
    case triangle = "Triangle"
}

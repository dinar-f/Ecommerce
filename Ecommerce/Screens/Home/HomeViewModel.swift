//
//  HomeViewModel.swift
//  Ecommerce
//
//  Created by Dinar on 23.03.2025.
//

import Foundation

struct Categories: Codable, Hashable {
    let id: Int
    let name: String
    let image: String
}

struct Product: Codable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let images: [String]
    
    struct Category: Codable, Hashable {
        let id: Int
        let name: String
    }
}

class HomeViewModel {
    var categoriesList: [Categories] = []
    var productsList: [Product] = []
}

//
//  FavouriteModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/26/25.
//

import Foundation
import SwiftUI
import Foundation
struct FavouriteModel: Codable {
    let listings: [Listing]?
    let pagination: Pagination?
}

// MARK: - Listing
struct Listing: Codable {
    let id: Int?
    let title: String?
    let city: String?
    let publicationDate: String?
    let mainImage: String?
    let price: String?
    let status : String?
    let type : String?
    var isFavourite: Bool = false
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case city
        case publicationDate = "publication_date"
        case mainImage = "main_image"
        case status = "status"
        case price
        case type = "type"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let total: Int?
    let perPage: Int?
    let currentPage: Int?
    let lastPage: Int?

    enum CodingKeys: String, CodingKey {
        case total
        case perPage = "per_page"
        case currentPage = "current_page"
        case lastPage = "last_page"
    }
}

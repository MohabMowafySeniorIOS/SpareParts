//
//  carAuctionModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/26/25.
//

import Foundation

// MARK: - AuctionItem
struct AuctionItemData: Codable {
    let id: Int?
    let title: String?
    let city: String?
    let publicationDate: String?
    let startDayDate: String?
    let endDayDate: String?
    let thumbnail: String?
    let carStatusText: String?
    let category: String?
    let model: String?
    let brand: String?
    let year: Int?
    let transmission: String?
    let startingPrice: String?
    let currentBid: String?
    let status: String?
    let bidsCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, city
        case publicationDate = "publication_date"
        case startDayDate = "start_day_date"
        case endDayDate = "end_day_date"
        case thumbnail
        case carStatusText = "car_status_text"
        case category, model, brand, year, transmission
        case startingPrice = "starting_price"
        case currentBid = "current_bid"
        case status
        case bidsCount = "bids_count"
    }
}

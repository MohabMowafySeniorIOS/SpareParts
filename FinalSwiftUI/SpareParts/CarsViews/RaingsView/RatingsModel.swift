//
//  RatingsModel.swift
//  MyAuctions
//
//  Created by Moaaz on 07/07/2025.
//

import Foundation
struct RatingCard: Identifiable {
    let id = UUID()
    let date: String
    let time: String
    let userName: String
    let rating: Double
    let ratingText: String
    let reviewText: String
}

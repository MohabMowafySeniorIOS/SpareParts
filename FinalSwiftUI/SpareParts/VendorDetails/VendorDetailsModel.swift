//
//  VendorDetailsModel.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 15/07/2025.
//

import Foundation

struct VendorDetailsModel: Decodable {
    let name: String
    let vendorImage: String
    let rating: Double
    let isfavorite: Bool
    let images: [String]
    let description: String
    let country: String
    let city: String
    let distance: String
}

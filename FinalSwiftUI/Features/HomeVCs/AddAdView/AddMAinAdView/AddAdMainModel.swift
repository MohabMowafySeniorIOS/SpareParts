//
//  AddAdMainModel.swift
//  MyAuctions
//
//  Created by Mohab on 03/07/2025.
//

import Foundation
import Foundation

// MARK: - ListingCreatedResponse

// MARK: - ListingData
struct ListingDetailsData: Codable {
    let userID: Int?
    let title: String?
    let cityID: String?
    let generalCategoryID: String?
    let description: String?
    let price: String?
    let contactPhone: String?
    let contactEmail: String?
    let status: String?
    let updatedAt: String?
    let createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case title
        case cityID = "city_id"
        case generalCategoryID = "general_category_id"
        case description
        case price
        case contactPhone = "contact_phone"
        case contactEmail = "contact_email"
        case status
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

struct FieldsTextBinds {
    var auctionName = ""
    var carDescibtion = ""
    var startDate = ""
    var endDate = ""
    var carState = ""
    var carModel = ""
    var accidents = ""
    var exOwners = ""
    var licenseState = ""
    var delayYears = ""
    var kilometres = ""
    var engineSize = ""
    var fuelType = ""
    var transmition = ""
    var startingPrice = ""
}
struct BarBoxModel: Identifiable {
    let id = UUID()
    let text: String
}

struct BarModel: Identifiable {
    var id = Int()
    let title: String
    var boxes: [CategoryData]
    var isExpanded: Bool = false

}

//
//  AddCustomeAdModel.swift
//  MyAuctions
//
//  Created by Mohab on 03/07/2025.
//

import Foundation
struct AddFavouriteModel: Codable {
    let is_favorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case is_favorite = "is_favorite"
     
    }
}

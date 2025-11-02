//
//  FilterCarModels.swift
//  MyAuctions
//
//  Created by Mohab on 03/07/2025.
//

import Foundation
import SwiftUI

struct CategoryData: Codable,Hashable {
    let id: Int?
    let name: String?
    let image: String?
   var is_selected : Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
      
    }
}

// MARK: - Brand
struct BrandData: Codable,Hashable {
    let id: Int?
    let name: String?
}

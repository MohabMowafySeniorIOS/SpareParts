//
//  cityModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/26/25.
//

import Foundation
import SwiftUI
struct CityModel: Codable,Identifiable {
    let id: Int?
    let name: String?
    var isActive: Bool = false
    enum CodingKeys: String, CodingKey {
        case id
        case name
      
    }
}

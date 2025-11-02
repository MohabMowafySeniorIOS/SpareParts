//
//  CreateOrderModel.swift
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
//

import Foundation
import SwiftUI

struct Car: Identifiable {
    let id = UUID()
    let name: String
    var isSelected: Bool
}
struct AddedAddressModel: Identifiable {
    let id = UUID()
    let address: String
    var isSelected: Bool
}

struct Part: Identifiable {
    let id = UUID()
    let name: String
    let number: String
    let count: String
    let type: String
}
enum DeliveryType{
    case shop
    case home
}




//
//  MyOrdersCardModel.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 18/07/2025.
//

import Foundation

struct MyOrdersCardModel: Codable {
    let data: [Order]?
    let links: PaginationLinks?
    let meta: PaginationMeta?
}

struct Order: Codable, Identifiable {
    let uid = UUID()
    let id: Int?
    let orderNumber: String?
    let orderType: OrderType?
    let deliveryType: DeliveryType?
    let status: OrderStatus?
    let vehicle: Vehicle?
    let itemsCount: Int?
    let totalAmount: Double?
    let paidAt: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderNumber = "order_number"
        case orderType = "order_type"
        case deliveryType = "delivery_type"
        case status, vehicle
        case itemsCount = "items_count"
        case totalAmount = "total_amount"
        case paidAt = "paid_at"
        case createdAt = "created_at"
    }
}

struct OrderType: Codable {
    let value: String?
    let label: String?
    let orderStatus: String?
    let statuses: [String]?

    enum CodingKeys: String, CodingKey {
        case value, label, statuses
        case orderStatus = "order_status"
    }
}

struct DeliveryType: Codable {
    let value: String?
    let label: String?
}

struct OrderStatus: Codable {
    let value: String?
    let label: String?
    let color: String?
}

struct Vehicle: Codable {
    let id: Int?
    let category: VehicleCategory?
    let brand: Brand?
    // Some orders can contain a vehicle without a model (for example when
    // the model was removed or was not selected). Keep decoding the order
    // details instead of failing the entire response.
    let model: VehicleModel?
    let year: Int?
    let chassisNumber: String?
    let isDefault: Bool?
    let fullName: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, brand, model, year, category
        case chassisNumber = "chassis_number"
        case isDefault = "is_default"
        case fullName = "full_name"
        case createdAt = "created_at"
    }
}

struct VehicleCategory: Codable {
    let id: Int?
    let name: String?
}


struct Brand: Codable {
    let id: Int?
    let name: String?
    let logo: Logo?
}

struct VehicleModel: Codable {
    let id: Int?
    let name: String?
}

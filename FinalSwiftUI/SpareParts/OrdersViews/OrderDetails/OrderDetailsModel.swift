//
//  OrderDetailsModel.swift
//  SpareParts
//
//  Created by Mohamed Elboraey on 11/02/2026.
//

import Foundation


struct OrderDetailsModel: Codable {
    let id: Int?
    let orderNumber: String?
    let orderType, deliveryType: DeliveryTypeClass?
    let status: Status?
    
    let vehicle: Vehicle?
    let address: Address?
    let items: [DataItem]?
    
    // 🔹 Role-based fields
    let client: OrderClient?
    let trader: OrderTrader?
    let isMyOrder: Bool?
    
    // 🔹 Offers
    let myOffer: Offer?
    let offers: [Offer]?
    let acceptedOffer: Offer?
    
    // 🔹 Pricing
    let subtotal, shippingCost, taxAmount, totalAmount: Double?
    let walletUsed: Double?
    
    // 🔹 Payment
    let paidAmount: Double?
    let paymentMethod, paidAt: String?
    
    // 🔹 Permissions
    let canRate, hasChat, canReport,can_download, canConfirmReceipt: Bool?
    let chatID: Int?
    let canCancel, canPay: Bool?
    
    // 🔹 Dates
    let completedAt, cancelledAt: String?
    let createdAt: String?
    
    // 🔹 Lookup
    let countries: [AttributeList]?
    let cities: [AttributeList]?
    let can_chat: Bool?
    // Mohm
    let problem_report: ProblemReport?

    let targets: [TargetItem]?

    // 🔹 Rating (يظهر بعد تقييم الطلب)
    let rating: OrderRating?
    let myRating: OrderRating?
    var ratingDetails: OrderRating? { rating ?? myRating }

    enum CodingKeys: String, CodingKey {
        case id
        case can_download = "can_download"
        case orderNumber = "order_number"
        case orderType = "order_type"
        case deliveryType = "delivery_type"
        case status, vehicle, address, items
        case client, trader
        case isMyOrder = "is_my_order"
        case myOffer = "my_offer"
        case offers
        case acceptedOffer = "accepted_offer"
        case subtotal
        case shippingCost = "shipping_cost"
        case taxAmount = "tax_amount"
        case totalAmount = "total_amount"
        case walletUsed = "wallet_used"
        case paidAmount = "paid_amount"
        case paymentMethod = "payment_method"
        case paidAt = "paid_at"
        case canRate = "can_rate"
        case hasChat = "has_chat"
        case canReport = "can_report"
        case canConfirmReceipt = "can_confirm_receipt"
        case chatID = "chat_id"
        case canCancel = "can_cancel"
        case canPay = "can_pay"
        case completedAt = "completed_at"
        case cancelledAt = "cancelled_at"
        case createdAt = "created_at"
        case countries, cities
        case can_chat = "can_chat"
        case problem_report = "problem_report"
        case targets = "targets"
        case rating = "rating"
        case myRating = "my_rating"
    }

}

// MARK: - OrderRating
struct OrderRating: Codable {
    let id: Int?
    let rating: Double?
    let comment: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, rating, comment
        case createdAt = "created_at"
    }

    init(from decoder: Decoder) throws {
        // الشكل الطبيعي: object فيه rating و comment
        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            id = try? values.decodeIfPresent(Int.self, forKey: .id)
            if let double = try? values.decodeIfPresent(Double.self, forKey: .rating) {
                rating = double
            } else if let int = try? values.decodeIfPresent(Int.self, forKey: .rating) {
                rating = Double(int)
            } else if let string = try? values.decodeIfPresent(String.self, forKey: .rating) {
                rating = Double(string)
            } else {
                rating = nil
            }
            comment = try? values.decodeIfPresent(String.self, forKey: .comment)
            createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        } else {
            // fallback: لو الـ API رجع رقم مباشر
            let single = try decoder.singleValueContainer()
            id = nil
            comment = nil
            createdAt = nil
            if let double = try? single.decode(Double.self) {
                rating = double
            } else if let string = try? single.decode(String.self) {
                rating = Double(string)
            } else {
                rating = nil
            }
        }
    }
}
import Foundation


// MARK: - Target Item
struct TargetItem: Codable {
    let targetType: TargetType
    let target: Target

    enum CodingKeys: String, CodingKey {
        case targetType = "target_type"
        case target
    }
}

// MARK: - Target Type
struct TargetType: Codable {
    let value: String
    let label: String
}

// MARK: - Target
struct Target: Codable {
    
    // Country
    let id: Int
    let name: String?
    let flag: flagModel?
    let isWholeCountry: Bool?
    let cities: [CityData]?
    
    // Trader
    let userID: Int?
    let tradeName: String?
    let logo: flagModel?
    let phone: String?
    let whatsapp: String?
    let ratingAvg: Double?
    let country: City?
    let city: City?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case flag
        case isWholeCountry = "is_whole_country"
        case cities
        case userID = "user_id"
        case tradeName = "trade_name"
        case logo
        case phone
        case whatsapp
        case ratingAvg = "rating_avg"
       
        case country = "country"
        case city = "city"
    }
}

struct flagModel: Codable {
    let id: Int?
    let is_single: Bool?
    let model_id: String?
    let model_type: String?
    let option: String?
    let path: String?
    let type: String?
    enum CodingKeys: String, CodingKey {
        case id
        case is_single = "is_single"
        case model_id = "model_id"
        case model_type = "model_type"
        case option = "option"
      case path = "path"
        case type = "type"
    }
}

struct ProblemReport: Codable {
    let id: Int
    let orderId: Int?
    let orderNumber: String?
    let reporterType: String?
    let problemType: ProblemType?
    let reason: Reason?
    let description: String?
    let status: ProblemStatus
    let adminNotes: String?
    let refundAmount: Double?
    let images: [ProblemImage]
    let resolvedAt: String?
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case orderId = "order_id"
        case orderNumber = "order_number"
        case reporterType = "reporter_type"
        case problemType = "problem_type"
        case reason
        case description
        case status
        case adminNotes = "admin_notes"
        case refundAmount = "refund_amount"
        case images
        case resolvedAt = "resolved_at"
        case createdAt = "created_at"
    }
}

struct ProblemType: Codable {
    let value: String
    let label: String
}

struct Reason: Codable {
    let id: Int
    let name: String
}

struct ProblemStatus: Codable {
    let value: String
    let label: String
    let color: String
}

struct ProblemImage: Codable {
    let id: Int
    let url: String
    let thumb: String
}

// MARK: - Address
struct Address: Codable {
    let id: Int?
    let title: String?
    let latitude, longitude: Double?
    let addressText, description: String?
    let isDefault: Bool?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, latitude, longitude
        case addressText = "address_text"
        case description
        case isDefault = "is_default"
        case createdAt = "created_at"
    }
}

// MARK: - DeliveryTypeClass
struct DeliveryTypeClass: Codable, Hashable {
    let value, label: String?
}

// MARK: - DataItem
struct DataItem: Codable, Hashable {
    let id: Int?
    let partName, partNumber: String?
    let partType: DeliveryTypeClass?
    let quantity: Int?
    let description: String?
    let images: [OrderImage]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case partName = "part_name"
        case partNumber = "part_number"
        case partType = "part_type"
        case quantity, description, images
    }
}

// MARK: - Image
struct OrderImage: Codable, Hashable {
    let id: String?
    let path: String?
    let type, option: String?
}

// MARK: - Offer
struct Offer: Codable, Equatable, Hashable {
    let id: Int?
    let trader: OrderTrader?
    let status: Status?
    let items: [OfferItem]?
    let subtotal, taxAmount, shippingCost, totalAmount: Double?
    let canAccept: Bool?
    let acceptedAt: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, trader, status, items, subtotal
        case taxAmount = "tax_amount"
        case shippingCost = "shipping_cost"
        case totalAmount = "total_amount"
        case canAccept = "can_accept"
        case acceptedAt = "accepted_at"
        case createdAt = "created_at"
       
    }
}

// MARK: - Trader
struct OrderTrader: Codable, Equatable, Hashable {
    let id, userID: Int?
    let tradeName: String?
    let logo: OrderLogo?
    let ratingAvg, ratingCount: Double?
    let phone, whatsapp: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case tradeName = "trade_name"
        case logo, phone, whatsapp
        case ratingAvg = "rating_avg"
        case ratingCount = "rating_count"
    }
}

struct OrderClient: Codable {
    let id: Int?
    let name: String?
    let phone: String?
    let image: OrderLogo?
}


// MARK: - OrderLogo
struct OrderLogo: Codable, Equatable, Hashable {
    let id: String?
    let path: String?
    let type, option: String?
    let modelID: String?
    let modelType: String?
    let isSingle: Bool?

    enum CodingKeys: String, CodingKey {
        case id, path, type, option
        case modelID = "model_id"
        case modelType = "model_type"
        case isSingle = "is_single"
    }
}

// MARK: - OfferItem
struct OfferItem: Codable, Equatable, Hashable {
    let id: Int?
    let orderItem: OrderItem?
    let price: Double?
    let isAvailable: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderItem = "order_item"
        case price
        case isAvailable = "is_available"
    }
}

// MARK: - OrderItem
struct OrderItem: Codable, Equatable, Hashable {
    let id: Int?
    let partName, partNumber: String?
    let quantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case partName = "part_name"
        case partNumber = "part_number"
        case quantity
    }
}

// MARK: - Status
struct Status: Codable, Equatable, Hashable {
    let value, label, color: String?
}

struct AttributeList: Codable {
    let id: Int?
    let name: String?
}
extension KeyedDecodingContainer {
    func decodeBoolFromInt(forKey key: Key) -> Bool? {
        if let bool = try? decode(Bool.self, forKey: key) { return bool }
        if let int = try? decode(Int.self, forKey: key) { return int == 1 }
        if let string = try? decode(String.self, forKey: key) {
            return string == "1" || string.lowercased() == "true"
        }
        return nil
    }
}

//
//  WalletModel.swift
//  SpareParts
//
//  Created by Mohab Mowafy on 22/07/2026.
//

import Foundation
import Foundation

struct UseWalletResponse: Codable {
    let data: UseWalletData?
    let message: String?
    let status: String?
}

struct UseWalletData: Codable {
    let order: UseWalletOrder?
    let fullyPaid: Bool?
    let remainingAmount: Double?

    enum CodingKeys: String, CodingKey {
        case order
        case fullyPaid = "fully_paid"
        case remainingAmount = "remaining_amount"
    }
}

struct UseWalletOrder: Codable {
    let id: Int?
    let orderNumber: String?
    let status: String?
    let subtotal: String?
    let shippingCost: String?
    let taxAmount: String?
    let totalAmount: String?
    let walletUsed: String?
    let paidAmount: String?
    let paymentMethod: String?
    let paidAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case orderNumber = "order_number"
        case status
        case subtotal
        case shippingCost = "shipping_cost"
        case taxAmount = "tax_amount"
        case totalAmount = "total_amount"
        case walletUsed = "wallet_used"
        case paidAmount = "paid_amount"
        case paymentMethod = "payment_method"
        case paidAt = "paid_at"
    }
}

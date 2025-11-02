//
//  TransActionModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/27/25.
//

import Foundation
import Foundation



// MARK: - TransactionsData
struct TransactionsData: Codable {
    let title: LocalizedText?
    let data: [TransactionItem]?
    let pagination: TransactionPagination?
}

// MARK: - LocalizedText
struct LocalizedText: Codable {
    let en: String?
    let ar: String?
}

// MARK: - TransactionItem
struct TransactionItem: Codable {
    let id: Int?
    let amount: String?
    let type: String?
    let referenceID: String?
    let description: String?
    let metadata: TransactionMetadata?
    let createdAt: String?
    

    enum CodingKeys: String, CodingKey {
        case id, amount, type
        case referenceID = "reference_id"
        case description
        case metadata
        case createdAt = "created_at"
    }
}

// MARK: - TransactionMetadata
struct TransactionMetadata: Codable {
    let paymentMethod: String?

    enum CodingKeys: String, CodingKey {
        case paymentMethod = "payment_method"
    }
}

// MARK: - TransactionPagination
struct TransactionPagination: Codable {
    let total: ValueWithLabel?
    let perPage: ValueWithLabel?
    let currentPage: ValueWithLabel?
    let lastPage: ValueWithLabel?

    enum CodingKeys: String, CodingKey {
        case total
        case perPage = "per_page"
        case currentPage = "current_page"
        case lastPage = "last_page"
    }
}

// MARK: - ValueWithLabel
struct ValueWithLabel: Codable {
    let value: Int?
    let label: LocalizedText?
}

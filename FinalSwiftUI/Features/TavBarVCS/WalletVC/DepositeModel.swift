//
//  DepositeModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/27/25.
//

import Foundation
import Foundation

// MARK: - DepositResponse
struct DepositResponse: Codable {
    let status: Bool?
    let code: String?
    let message: String?
    let data: DepositData?
}

// MARK: - DepositData
struct DepositData: Codable {
    let transaction: DepositTransaction?
    let newBalance: String?

    enum CodingKeys: String, CodingKey {
        case transaction
        case newBalance = "new_balance"
    }
}

// MARK: - DepositTransaction
struct DepositTransaction: Codable {
    let userID: Int?
    let amount: String?
    let type: String?
    let referenceID: String?
    let description: String?
    let metadata: TransactionMetadata?
    let updatedAt: String?
    let createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case amount
        case type
        case referenceID = "reference_id"
        case description
        case metadata
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}


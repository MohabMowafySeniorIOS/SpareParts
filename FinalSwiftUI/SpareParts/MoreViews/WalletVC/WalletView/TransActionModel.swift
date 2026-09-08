//
//  TransActionModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/27/25.
//

import Foundation
import Foundation

import Foundation
struct WithDrawData : Codable {
    let withdraw_request : Withdraw_request?
    let wallet : Wallet?

    enum CodingKeys: String, CodingKey {

        case withdraw_request = "withdraw_request"
        case wallet = "wallet"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        withdraw_request = try values.decodeIfPresent(Withdraw_request.self, forKey: .withdraw_request)
        wallet = try values.decodeIfPresent(Wallet.self, forKey: .wallet)
    }

}

struct Wallet : Codable {
    let id : Int?
    let balance : String?
    let withdrawal_balance : String?
    let total_balance : Double?
    let formatted_balance : String?
    let formatted_withdrawal_balance : String?
    let formatted_total_balance : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case balance = "balance"
        case withdrawal_balance = "withdrawal_balance"
        case total_balance = "total_balance"
        case formatted_balance = "formatted_balance"
        case formatted_withdrawal_balance = "formatted_withdrawal_balance"
        case formatted_total_balance = "formatted_total_balance"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

   

}
struct Withdraw_request : Codable {
    let id : Int?
    let amount : String?
    let formatted_amount : String?
    let bank_name : String?
    let account_name : String?
    let account_number : String?
    let iban : String?
    let status : String?
    let status_label : String?
    let approved_at : String?
    let rejected_at : String?
    let created_at : String?
    let time_ago : String?
    let transfere_image: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case amount = "amount"
        case formatted_amount = "formatted_amount"
        case bank_name = "bank_name"
        case account_name = "account_name"
        case account_number = "account_number"
        case iban = "iban"
        case status = "status"
        case status_label = "status_label"
        case approved_at = "approved_at"
        case rejected_at = "rejected_at"
        case created_at = "created_at"
        case time_ago = "time_ago"
        case transfere_image = "transfere_image"
    }

  
}



// MARK: - TransactionsData
struct TransactionsData: Codable {
    let data: [TransactionItem]?
}

struct WithDrawDataModel: Codable {
    let data: [Withdraw_request]?
}


// MARK: - TransactionItem
struct TransactionItem: Codable,Equatable, Hashable {
    let id : Int?
    let wallet_id : Int?
    let type : String?
    let status : String?
    let status_label: String?
    let amount : String?
    let formatted_amount : String?
    let description : String?
    let is_credit : Bool?
    let is_up : Bool?
    let meta : metaModel?
    let created_at : String?
    let updated_at : String?
    let created_at_format : String?
    let bank_name : String?
    let account_name : String?
    let account_number : String?
    let iban : String?
    let transfer_image: String?
    let order_number: String?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case wallet_id = "wallet_id"
        case type = "type"
        case status = "status"
        case amount = "amount"
        case formatted_amount = "formatted_amount"
        case description = "description"
        case is_credit = "is_credit"
        case is_up = "is_up"
        case meta = "meta"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case created_at_format = "created_at_format"
        case bank_name = "bank_name"
        case account_name = "account_name"
        case account_number = "account_number"
        case iban = "iban"
        case transfer_image = "transfer_image"
        case status_label = "status_label"
        case order_number = "order_number"
    }

   

}

struct metaModel: Codable,Equatable, Hashable {
    let order_id : Int?
   
    
    enum CodingKeys: String, CodingKey {

        case order_id = "order_id"
    
    }

   

}
// MARK: - TransactionItem
struct WithDrawItem: Codable {
    let id : Int?
    let amount : String?
    let formatted_amount : String?
    let wallet_id : Int?
    let type : String?
    let status : String?
   
    let description : String?
    let is_credit : Bool?
    let is_up : Bool?
    let meta : String?
    let created_at : String?
    let updated_at : String?
    let created_at_format : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case wallet_id = "wallet_id"
        case type = "type"
        case status = "status"
        case amount = "amount"
        case formatted_amount = "formatted_amount"
        case description = "description"
        case is_credit = "is_credit"
        case is_up = "is_up"
        case meta = "meta"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case created_at_format = "created_at_format"
    }

   

}

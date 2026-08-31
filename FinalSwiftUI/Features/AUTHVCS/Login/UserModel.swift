//
//  UserModel.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 28/11/2024.
//


import Foundation

struct LoginData: Codable {
    var id : String?
    var full_name : String?
    var user_type : String?
    var email : String?
    var avatar : Avatar?
    var phone : String?
    var is_active : Bool?
    var locale : String?
    var is_notify : Bool?
    var token : String?
    var city_id : Int?
    var city_name : String?
    var country_id : Int?
    var country_name : String?
    var trader: Trader?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case full_name = "full_name"
        case user_type = "user_type"
        case email = "email"
        case avatar = "avatar"
        case phone = "phone"
        case is_active = "is_active"
        case locale = "locale"
        case is_notify = "is_notify"
        case token = "token"
        case city_id = "city_id"
        case city_name = "city_name"
        case country_id = "country_id"
        case country_name = "country_name"
        
        case trader    = "trader"
    }

    
}
struct Avatar : Codable {
    let id : String?
    let path : String?
    let type : String?
    let option : String?
    let model_id : String?
    let model_type : String?
    let is_single : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case path = "path"
        case type = "type"
        case option = "option"
        case model_id = "model_id"
        case model_type = "model_type"
        case is_single = "is_single"
    }

   
}

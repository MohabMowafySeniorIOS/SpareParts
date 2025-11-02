//
//  UserModel.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 28/11/2024.
//


import Foundation

struct LoginData: Codable {
    var user: UserData?
    let token: String?
}

struct UserData: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let phone: String?
    let identityNumber: String?
    let status: String?
    let phoneVerifiedAt: String?
    let emailVerifiedAt: String?
    let profileImage: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case identityNumber = "identity_number"
        case status
        case phoneVerifiedAt = "phone_verified_at"
        case emailVerifiedAt = "email_verified_at"
        case profileImage = "profile_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

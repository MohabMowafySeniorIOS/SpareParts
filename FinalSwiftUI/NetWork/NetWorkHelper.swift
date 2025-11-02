//
//  NetWorkHelper.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 12/01/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case serverError(String)
    case decodingError
    case NotAuthorized
    case ParamterError
}

public enum HTTPMethodType: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
public enum EndPoints: String {
    
    //MARK: AUTH
    case register = "register"
    case Login = "login"
    case verify_phone = "verify-phone"
    case resend_otp = "resend-otp"
    case forgot_password = "forgot-password"
    case reset_password = "reset-password"
    case logout = "logout"
    
    //MARK: UserProfile
    case profile = "profile"
    case account_request_deletion = "account/request-deletion"
   
    
    //MARK: Car categories
    case categories
    
    //MARK: Car Brands
    case brands = "brands"
    
    //MARK: Cities
    case cities = "cities"
    
    //MARK: General Categories
    case general_categories = "general-categories"
    
    
    //MARK: General Listings
    case listings = "listings"
    case my_listings = "my-listings"
    case favorites_listings = "favorites/listings"
    
    //MARK: Car Auctions
    case auctions = "auctions"
    case my_participations = "my-participations"
    case favorites_auctions = "favorites/auctions"
    
    //MARK: Wallet
    case wallet_balance = "wallet/balance"
    case wallet_transactions = "wallet/transactions"
    case wallet_deposit = "wallet/deposit"
    case wallet_withdraw = "wallet/withdraw"
    
    //MARK: Contact US
    case contact_us = "contact-us"
    
    // MARK: Notifications
    case notifications = "notifications"
    case notifications_unread_count = "notifications/unread-count"
    case notifications_read_all = "notifications/read-all"
    
    //MARK: Settings&Contents
    case settings_public = "settings/public"
    case settings_about = "settings/about"
    case settings_terms = "settings/terms"
    case settings_privacy = "settings/privacy"
    case settings_faq = "settings/faq"
    
    
}

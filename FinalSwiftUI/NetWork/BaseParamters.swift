//
//  أشسث[شقشوفثقس.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 13/01/2025.
//



import Foundation
struct BaseParameters {
    
    //MARK: Auth Paramter
    var name : String = ""
    var email : String = ""
    var identity_number = ""
    var city_id = ""
    var password_confirmation = ""
    var current_password = ""
    var agree_terms = "true"
    var phone: String = ""
    var otp : String = ""
    var password : String = ""
    
    
    //MARK: Listings Paramter
    var _method = ""
    var title = ""
  
    var description = ""
    var price = ""
    var contact_phone = ""
    var contact_email = ""
    
    //MARK: Listings Paramter
    var category_id = ""
    var general_category_id = ""
    var brand_id = ""
    var model_id = ""
   var year = ""
    var start_time = ""
    var end_time = ""
    var condition = ""
    var accidents_count = ""
    var previous_owners = ""
    var papers_status = ""
    var delay_years = ""
    var mileage = ""
   var color = ""
    var engine_size = ""
    var fuel_type = ""
    var transmission = ""
    var starting_price = ""
    var reserve_price = ""
    
    var amount = ""
     var payment_method = ""
     var bank_account = ""
     var bank_name = ""
     var account_holder = ""
    
    var message_type = ""
    var subject = ""
    var message = ""
    
    
    var car_condition = ""
   
    
}

extension BaseParameters {
    func toDictionary() -> [String: Any] {
        
        var parameters: [String: Any] = [:]
        
        
        //MARK: Auth Paramter
        if !name.isEmpty {
            parameters["name"] = name
        }
        
        if !email.isEmpty {
            parameters["email"] = email
        }
        
        if !identity_number.isEmpty {
            parameters["identity_number"] = identity_number
        }
        
        if !city_id.isEmpty {
            parameters["city_id"] = city_id
        }
        
        if !password_confirmation.isEmpty {
            parameters["password_confirmation"] = password_confirmation
        }
        
        if !current_password.isEmpty {
            parameters["current_password"] = current_password
        }
        
        
        if !agree_terms.isEmpty {
            parameters["agree_terms"] = agree_terms
        }
        
        if !previous_owners.isEmpty {
            parameters["previous_owners"] = previous_owners
        }
        
        if !start_time.isEmpty {
            parameters["start_time"] = start_time
        }
        
        
        if !phone.isEmpty {
            parameters["phone"] = phone
        }
        
        if !otp.isEmpty {
            parameters["otp"] = otp
        }
        
        if !password.isEmpty {
            parameters["password"] = password
        }
        
      
        //MARK: Listings Paramter
        if !_method.isEmpty {
            parameters["_method"] = _method
        }
        if !title.isEmpty {
            parameters["title"] = title
        }
        if !general_category_id.isEmpty {
            parameters["general_category_id"] = general_category_id
        }
        if !description.isEmpty {
            parameters["description"] = description
        }
        if !price.isEmpty {
            parameters["price"] = price
        }
        if !contact_phone.isEmpty {
            parameters["contact_phone"] = contact_phone
        }
        if !contact_email.isEmpty {
            parameters["contact_email"] = contact_email
        }
       
        //MARK: Listings Paramter
       
      
     
        
        if !category_id.isEmpty {
            parameters["category_id"] = category_id
        }
        
        if !contact_email.isEmpty {
            parameters["brand_id"] = brand_id
        }
        
        if !brand_id.isEmpty {
            parameters["brand_id"] = brand_id
        }
        
        
        if !model_id.isEmpty {
            parameters["model_id"] = model_id
        }
        
        if !starting_price.isEmpty {
            parameters["starting_price"] = starting_price
        }
        
        if !transmission.isEmpty {
            parameters["transmission"] = transmission
        }
        if !fuel_type.isEmpty {
            parameters["fuel_type"] = fuel_type
        }
        
        if !engine_size.isEmpty {
            parameters["engine_size"] = engine_size
        }
        
        if !color.isEmpty {
            parameters["color"] = color
        }
        
       
        if !year.isEmpty {
            parameters["year"] = year
        }
        
        if !end_time.isEmpty {
            parameters["end_time"] = end_time
        }
        
        if !condition.isEmpty {
            parameters["condition"] = condition
        }
        
        
        if !papers_status.isEmpty {
            parameters["papers_status"] = papers_status
        }
        
        if !delay_years.isEmpty {
            parameters["delay_years"] = delay_years
        }
        
        if !mileage.isEmpty {
            parameters["mileage"] = mileage
        }
        
        if !amount.isEmpty {
            parameters["amount"] = amount
        }
        
        if !payment_method.isEmpty {
            parameters["payment_method"] = payment_method
        }
        
        if !bank_account.isEmpty {
            parameters["bank_account"] = bank_account
        }
        
        if !bank_name.isEmpty {
            parameters["bank_name"] = bank_name
        }
        
        if !account_holder.isEmpty {
            parameters["account_holder"] = account_holder
        }
        if !message_type.isEmpty {
            parameters["message_type"] = message_type
        }
        if !subject.isEmpty {
            parameters["subject"] = subject
        }
        if !message.isEmpty {
            parameters["message"] = message
        }
        
        if !car_condition.isEmpty {
            parameters["car_condition"] = car_condition
        }
        
        
        
        
        return parameters
    }
}

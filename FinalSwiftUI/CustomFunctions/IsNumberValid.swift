//
//  IsNumberValid.swift
//  MyAuctions
//
//  Created by Moaaz on 02/07/2025.
//
import SwiftUI


func isNumberValid(text: String) ->  (Bool,String) {
    
    let phoneRegex = #"^5\d{8}$"#
    let isValidPhone = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: text)
    
    if isValidPhone {
        return (true,"")
    }else{
        return (false,"invalid number")
    }
}

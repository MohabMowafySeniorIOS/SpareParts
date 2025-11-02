//
//  CustomeTextField.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 27/11/2024.
//

import Foundation
import SwiftUI

enum textfieldTypes {
    case userNAme
    case Email
    case City
    case Id
    case BankAccount
    case Phone
    case Password
    case ConfirmPassword
    case messageType
    
}

// Custom TextField Component
import SwiftUI

// Custom TextField Component
struct CustomTextField: View {
    @Binding var text: String
    @State var title_label: String?
    @Binding var Validation_label: String
    @Binding var is_validation_label: Bool
    @State var is_title_label: Bool
    @State private var isEditing = false
    @State var placeholder: String?
    @State var textType : textfieldTypes
    
    var body: some View {
        VStack(spacing:4) {
            VStack(spacing:8) {
                HStack {
                    CustomLabel_text(imageName: title_label ?? "", labelText: title_label ?? "")
                    Spacer()
                }
                ZStack {
                    TextField(placeholder ?? "", text: $text, onEditingChanged: { editing in
                        isEditing = editing})
                    .keyboardType(.default)
                    .padding()
                    .frame(height: 48)
                    .background((isEditing || !text.isEmpty) ? Color.clear : Color.clear) // Change
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke((isEditing || !text.isEmpty) ? Color.MainColor : Color.TextBorderColor, lineWidth: 1))
                }
                if !is_validation_label {
                    HStack{
                        Text(Validation_label.localized)
                            .font(addFont(fontType: .Medium, size: 12))
                            .foregroundStyle(.cRed)
                        
                        Spacer()
                    }
                }
                
            }
            .onAppear() {
                switch textType {
                    
                case .userNAme:
                    title_label = "full_name".localized
                    placeholder = "enter_name".localized
                    
                case .Email:
                    title_label = "email".localized
                    placeholder = "name@gmail.com".localized
                    
                case .City:
                    title_label = "city".localized
                    placeholder = "gaddah".localized
                    
                case .Id:
                    title_label = "id_number".localized
                    placeholder = "23489756".localized
                    
                case .BankAccount:
                    title_label = "bank_account_number".localized
                    placeholder = "2389476342".localized
                    
                case .Phone:
                    title_label = "phone_number".localized
                    placeholder = "538804683".localized
                    
                case .Password:
                    title_label = "password".localized
                    placeholder = "**********".localized
                    
                case .ConfirmPassword:
                    title_label = "confirm_password".localized
                    placeholder = "**********".localized
                    
                case .messageType:
                    title_label = "Message_Title".localized
                    placeholder = "hello".localized
                }
            }
        }
    }
    
    
    
}


struct SelectCustomTextField: View {
    @Binding var text: String
    @Binding var title_label: String
    @Binding var Validation_label: String
    @Binding var is_validation_label: Bool
    @Binding var is_title_label: Bool
    @Binding var isRequired :Bool
    @State var isPhoneNumber : Bool
    @State private var isEditing = false
    @State var isSelectable : Bool
    
    var placeholder: String
    
    
    var action: () -> Void // Action closure
    var body: some View {
        VStack(spacing:4) {
            VStack(spacing:8) {
                CustomLabel_text(imageName: title_label, labelText: title_label)
                ZStack {
                    TextField(placeholder, text: $text, onEditingChanged: { editing in
                        isEditing = editing})
                    .keyboardType(isPhoneNumber ? .phonePad : .default)
                    .padding()
                    
                    .frame(height: 48)
                    .background((isEditing || !text.isEmpty) ? Color.TextBorderColor.opacity(0.1) : Color.clear) // Change
                    .cornerRadius(8)
                    
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke((isEditing || !text.isEmpty) ? Color.TextBorderColor : Color.gray.opacity(0.1), lineWidth: 1))
                    
                    SelectedContentButtonView(title: "") {
                        action()
                        
                    }
                }
                
                // Optional: You can add more customizations like error messages or icons here.
            }
            
        }
        
    }
}


struct textfieldExample: View {
    @State private var countryInput = ""
    @State private var country_title_label = "Country"
    @State private var country_Validation_label = "Country Is Required"
    @State private var isLabelHiddenCountry = true
    @State private var isRequiredCountry = true
    
    var body: some View {
        VStack {
            //  Text("Rate Us!")
            //   .font(.headline)
            
            SelectCustomTextField(text: $countryInput, title_label: $country_title_label, Validation_label: $country_Validation_label, is_validation_label: $isLabelHiddenCountry, is_title_label: $isLabelHiddenCountry, isRequired: $isRequiredCountry, isPhoneNumber: false, isSelectable: true, placeholder: "Choose Country", action: {
                print("dasdasdas")
                
            })
            
            
            //  Text("Your Rating: \(userRating)")
            //     .font(.subheadline)
        }
        .padding()
    }
}

struct textfieldExampleExample_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), Validation_label: .constant("required"), is_validation_label: .constant(false), is_title_label: true, textType: .BankAccount)
    }
}


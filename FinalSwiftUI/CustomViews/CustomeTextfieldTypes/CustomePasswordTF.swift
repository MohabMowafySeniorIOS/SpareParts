//
//  CustomePasswordTF.swift
//  FinalSwiftUI
//
//  Created by Mohab on 15/05/2025.
//

import SwiftUI

struct CustomePasswordTF: View {
    @Binding var text: String
    @Binding var title_label: String
    @Binding var Validation_label: String
    @Binding var is_validation_label: Bool
   
    @State private var isEditing = false
    @State var isSelectable : Bool
    @State var showTitle :Bool
    @State var isSecure: Bool = true
    
    @FocusState private var isFocused: Bool
    
    
    var placeholder: String
  
    
  
    var body: some View {
            VStack(spacing:4) {
                VStack(spacing:8) {
                    if showTitle {
                        HStack {
                            CustomLabel_text(imageName: title_label, labelText: title_label)
                            Spacer()
                        }
                       
                    }
                   
                    HStack {
                        if isSecure {
                            TextField(placeholder, text: $text, onEditingChanged: { editing in
                                            isEditing = editing})
                            .keyboardType(.default)
                        }else{
                            SecureField(placeholder, text: $text)
                                .keyboardType(.default)
                                .focused($isFocused)
                                .onChange(of: isFocused) { editing in
                                    isEditing = editing
                                }
                        }
                            
                        if isSelectable {
                            
                            SelectedContentButtonView(title: "") {
                                
                               
                            }
                        }
                        
                        HStack {
                            Spacer()
                            HStack {
                                if !isSecure{
                                    Image(systemName: "eye.slash.fill")
                                        .renderingMode(.template)
                                        .foregroundStyle(.main)
                                }else{
                                    Image(systemName: "eye")
                                        .renderingMode(.template)
                                        .foregroundStyle(.main)
                                }
                            }
                            
                        }
                        .onTapGesture {
                            isSecure.toggle()
                        }
                    }
                    .padding()
                    .frame(height: 48)
                    .background((isEditing || !text.isEmpty) ? Color.clear : Color.clear) // Change
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke((isEditing || !text.isEmpty) ? Color.MainColor : Color.TextBorderColor, lineWidth: 1))
              
                   
                    // Optional: You can add more customizations like error messages or icons here.
                }
                if !is_validation_label {
                    CustomValidationLabel(imageName: "star.fill", labelText: Validation_label.localized)
                }
        }
      
    }
}

func isPasswordValid(password: String) -> (Bool,String) {
    if password == "" || password.isEmpty {
        return (false,"invalid password")
    }else{
        return (true,"")
    }
}

#Preview {
    CustomePasswordTF(text: .constant(""), title_label: .constant(""), Validation_label: .constant(""), is_validation_label: .constant(false), isSelectable: false, showTitle: false, placeholder: "")
}

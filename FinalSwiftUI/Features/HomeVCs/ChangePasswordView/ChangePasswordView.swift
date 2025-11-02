//
//  EnterPhoneNumberView.swift
//  Auctions
//
//  Created by Moaaz on 02/06/2025.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @StateObject private var viewModel = ChangePasswordViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    @State private var isNavigating = false
    @State private var showAlert = false
    @State private var validationError = ""
    
    @Binding var otp : String
    @Binding var phone : String
    
    @State var fieldText: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState : AppState
    @State var tfLabel: String = ""
    @State var validationLabel: String = ""
    @State var isValidationLabel: Bool = false
    @State var isSelected: Bool = false
    @State var showTitle: Bool = false
   
    var body: some View {
        
        NavigationStack {
           
                ZStack {
                    errorToast
                    if viewModel.isLoading == true {
                        LoaderView(rotation: $rotation, isLoading: $isLoading)
                            .frame(width: 100, height: 100)
                    } else {
                        mainContent
                    }
                }
             
                .onReceive(viewModel.$userData) { Model in
                    guard let userData = Model else { return }
                    appState.logout()
                }
                
            }
          
       
    }
    
    
    // MARK: - Error Toast
    
    @ViewBuilder
    private var errorToast: some View {
        if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
            ToastView(message: errorMessage, backgroundColor: .cRed)
                .transition(.move(edge: .top))
                .zIndex(0.1)
        }
    }
    
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        
        NavigationStack{
            AuthHeaderView(Title: "") {
                dismiss()
            }
            ScrollView{
                VStack(){
                    Image(.languageLogo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150,height: 120)
                    
                    Text("enter_new_password".localized)
                        .padding(.bottom,40)
                    
                    CustomePasswordTF(text: $fieldText, title_label: $tfLabel, Validation_label: $validationLabel, is_validation_label: $isValidationLabel, isSelectable: isSelected, showTitle: showTitle, placeholder: "enter_new_password".localized)
                        .padding(.horizontal)
                    
                    CustomePasswordTF(text: $fieldText, title_label: $tfLabel, Validation_label: $validationLabel, is_validation_label: $isValidationLabel, isSelectable: isSelected, showTitle: showTitle, placeholder: "confirm_password".localized)
                        .padding(.horizontal)

                    //"confirm"
                    ContentButtonView(title: "confirm".localized) {
                        viewModel.fetchUsers(parameters: .init(password_confirmation:fieldText, phone :phone,otp: otp,password: fieldText))
                    }
                    .padding()
                    .padding(.top,50)
                    .padding(.horizontal,25)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
}

#Preview {
    ChangePasswordView(otp: .constant(""), phone: .constant(""))
}

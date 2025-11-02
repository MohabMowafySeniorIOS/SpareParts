//
//  ForgetPassVc.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/6/25.
//

import SwiftUI
import Combine

struct ForgetPassVc: View {
    // MARK: NavigationVariable
   
    @State private var isActive = false
    // MARK: - State & ViewModel
    
    @StateObject private var viewModel = ForgetPasswordViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    @State private var isNavigating = false
    @State private var showAlert = false
    @State private var validationError = ""
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Phone State
    
    @State private var phoneInput = ""
    var phoneTitleLabel = "Phone Number".localized
    @State private var phoneValidationLabel = "Phone Number Is Required".localized
    @State private var isLabelHiddenPhone = true
    @State private var isRequiredPhone = true
    
    @State private var isForgetPassw = true
    @State private var isNumberAlert: Bool = false
    // MARK: - View
    
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
                }.onReceive(viewModel.$Model) { Model in
                    guard let userData = Model else { return }
                    self.isActive = true
                }
                .navigationDestination(isPresented: $isActive) {
                    OTPView(isForgetPass: $isForgetPassw, phone : $phoneInput).navigationBarHidden(true)
                }
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - Error Toast
    
    @ViewBuilder
    private var errorToast: some View {
        if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
            ToastView(message: errorMessage, backgroundColor: .red)
                .transition(.move(edge: .top))
                .zIndex(1)
        }
    }
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        VStack{
            AuthHeaderView(Title: "password_reset".localized) {
                dismiss()
            }
            ScrollView {
                VStack(spacing: 16) {
                    VStack(spacing: 40) {
                        logoSection
                        formSection
                    }
                }
                .padding(16)
            }
            .mask(RoundedRectangle(cornerRadius: 0))
        }
    }
    
    // MARK: - Logo Section
    
    private var logoSection: some View {
        VStack(spacing: 40) {
            Image.Splashlogo
                .resizable()
                .logoSize()
            
            Text("enter_phone_number".localized)
                .font(.custom(AppFont.SemiBold.rawValue, size: 19))
                .foregroundColor(Color.TitleColor)
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: - Form Section
    
    private var formSection: some View {
        VStack(spacing: 140) {
            VStack(spacing: 24) {
                CustomMobileTextField(
                    text: $phoneInput,
                    Validation_label: $phoneValidationLabel,
                    is_validation_label: $isLabelHiddenPhone,
                    isPhoneNumber: true,
                    isSelectable: false,
                    showTitle: false,
                    placeholder: "phone_placeholder".localized
                )
                if isNumberAlert{
                    HStack{
                        Spacer()
                        Text("phone_number_incorrect".localized)
                            .foregroundStyle(.cRed)
                            .font(addFont(fontType: .Medium, size: 12))
                        
                    }
                }
            }
            
            buttonSection
                .padding(.horizontal)
                .padding(.horizontal)
        }
    }
    
    // MARK: - Button Section
    
    private var buttonSection: some View {
        VStack(spacing: 12) {
            var cancelable = Cancelable()
            ContentButtonView(title: "confirm_button".localized) {
                if isNumberValid(text: phoneInput).0 {
                    viewModel.forgotPass(urlEndPoint: .forgot_password, methodType: .post, parameters: .init(phone: phoneInput))
                }else{
                    isNumberAlert = true
                }
            }
           
        }
    }
}

#Preview {
    ForgetPassVc()
}

//
//  RegisterVC.swift
//  FinalSwiftUI
//
//  Created by Mohab on 17/05/2025.
//

import SwiftUI

enum Cities: String, CaseIterable, Identifiable{
    case riadh
    case madena
    case gaddah
    case makkah
    case breda
    
    var id: String {rawValue}
    
    var cityName: String {
        switch self {
            case .riadh: return "riadh".localized
            case .madena: return "madina".localized
            case .gaddah: return "jaddah".localized
            case .makkah: return "makkah".localized
            case .breda: return "preda".localized
        }
    }
    
}

enum Areas: String, CaseIterable, Identifiable{
    case riadh
    case madena
    case gaddah
    case makkah
    case breda
    
    var id: String {rawValue}
    
    var areaName: String {
        switch self {
            case .riadh: return "riadh".localized
            case .madena: return "madina".localized
            case .gaddah: return "jaddah".localized
            case .makkah: return "makkah".localized
            case .breda: return "preda".localized
        }
    }
    
}


class CustomTFieldState: ObservableObject {
    @Published var input: String = ""
    @Published var validationLabel: String = ""
    @Published var isValidationHidden: Bool = true
    
    init(validationLabel: String) {
        self.validationLabel = validationLabel
    }
    
}

class PasswordTFieldState: ObservableObject {
    @Published var input: String = ""
    @Published var validationLabel: String = ""
    @Published var isValidationHidden: Bool = true
    @Published var titleLabel: String = ""
    
    init(validationLabel: String,titleLabel: String) {
        self.validationLabel = validationLabel
        self.titleLabel = titleLabel
    }
    
}

struct RegisterVC: View {
    
    @StateObject var nameField = CustomTFieldState(validationLabel: "name_required")
    @StateObject var phoneField = CustomTFieldState(validationLabel: "phone_number_required")
    @StateObject var emailField = CustomTFieldState(validationLabel: "email_required")
    @StateObject var idField = CustomTFieldState(validationLabel: "id_required")
    @StateObject var bankField = CustomTFieldState(validationLabel: "bank_required")
    @StateObject var passwordField = PasswordTFieldState(validationLabel: "password_required", titleLabel: "password".localized)
    @StateObject var confirmpasswordField = PasswordTFieldState(validationLabel: "confirm_password_required", titleLabel: "confirm_password".localized)
    
    @State private var isForgetPassw = false
    @Environment(\.dismiss) var dismiss
    
    @State private var isNavigating = false
    @State private var isPresented: Bool = false
    @State private var rotation: Double = 0
    @State private var isLoading = true
    
    @StateObject private var viewModel = LoginViewModel()
    
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage? = nil
        
    @State private var ValidationErr = ""
    @State private var showAlert = false
    
    @State private var termsIsSelected = false
    
    @State private var naviToOtp: Bool = false
    @State private var checkboxalert: Bool = false
    @State private var textColorChange: Bool = false
    
    @State var city: Cities = .riadh
    @State var area: Areas = .riadh
    
    var body: some View {
        ZStack {
            NavigationLink("", destination: OTPView(isForgetPass: $isForgetPassw, phone : $phoneField.input), isActive: $naviToOtp)
            if viewModel.errorMessage != nil , viewModel.errorMessage != "" {
                ToastView(message: viewModel.errorMessage ?? "", backgroundColor: .red)
                    .transition(.move(edge: .top))
                    .zIndex(1) // To make sure the toast is above other content
            }
            if viewModel.isLoading ?? false{
                LoaderView(rotation: $rotation, isLoading: $isLoading)
                    .frame(width: 100, height: 100)
            }else {
                VStack{
                    AuthHeaderView(Title: "") {
                        dismiss()
                    }
                    ZStack {
                        ScrollView {
                            VStack(spacing: 16) {
                                VStack(spacing: 51) {
                                    VStack(spacing: 35) {
                                        Image.Splashlogo
                                            .resizable()
                                            .logoSize()
                                        
                                        Text("register_title".localized)
                                            .font(.custom(AppFont.SemiBold.rawValue, size: 18))
                                            .foregroundColor(Color.TitleColor)
                                            .multilineTextAlignment(.center)
//                                        if let selectedImage = selectedImage{
//                                            Image(uiImage: selectedImage)
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: 130, height: 130)
//                                                .clipShape(Circle())
//                                                .shadow(radius: 5)
//                                        }else {
//                                            Image.CamerICon
//                                        }
                                    }
//                                    .onTapGesture {
//                                        showImagePicker = true
//                                    }
//                                    .sheet(isPresented: $showImagePicker, onDismiss: {
//                                        if let image = selectedImage,
//                                           let imageData = image.pngData() {
//                                            UserDefaults.standard.set(imageData, forKey: "profileImage")
//                                        }
//                                    }) {
//                                        ImageOnePicker(image: $selectedImage)
//                                    }
                                    .navigationBarBackButtonHidden()
                                    
                                    VStack(spacing:16) {
                                        
                                        CustomTextField(
                                            text: $nameField.input,
                                            Validation_label: $nameField.validationLabel,
                                            is_validation_label: $nameField.isValidationHidden,
                                            is_title_label: true,
                                            textType: .userNAme
                                        )
                                        
                                        CustomMobileTextField(
                                            text: $phoneField.input,
                                            Validation_label: $phoneField.validationLabel,
                                            is_validation_label: $phoneField.isValidationHidden,
                                            isPhoneNumber: true,
                                            isSelectable: false,
                                            showTitle: true,
                                            placeholder: "583694601".localized
                                        )
                                        
                                        CustomTextField(
                                            text: $emailField.input,
                                            Validation_label: $emailField.validationLabel,
                                            is_validation_label: $emailField.isValidationHidden,
                                            is_title_label: true,
                                            textType: .Email
                                        )
                                        
                                        GenericDropdown(
                                            title: "city",
                                            selectedItem: $city,
                                            items: Cities.allCases,
                                            displayText: { $0.cityName }
                                        )
                                        
                                        GenericDropdown(
                                            title: "area",
                                            selectedItem: $area,
                                            items: Areas.allCases,
                                            displayText: { $0.areaName }
                                        )
                                        
                                        CustomePasswordTF(
                                            text: $passwordField.input,
                                            title_label: $passwordField.titleLabel,
                                            Validation_label: $passwordField.validationLabel,
                                            is_validation_label: $passwordField.isValidationHidden,
                                            isSelectable: false,
                                            showTitle: true,
                                            placeholder: "*********".localized
                                        )
                                        
                                        CustomePasswordTF(
                                            text: $confirmpasswordField.input,
                                            title_label: $confirmpasswordField.titleLabel,
                                            Validation_label: $confirmpasswordField.validationLabel,
                                            is_validation_label: $confirmpasswordField.isValidationHidden,
                                            isSelectable: false,
                                            showTitle: true,
                                            placeholder: "*********".localized
                                        )
                                        
//                                        CustomTextField(
//                                            text: $idField.input,
//                                            Validation_label: $idField.validationLabel,
//                                            is_validation_label: $idField.isValidationHidden,
//                                            is_title_label: true,
//                                            textType: .Id
//                                        )
//                                        
//                                        
//                                        CustomTextField(
//                                            text: $bankField.input,
//                                            Validation_label: $bankField.validationLabel,
//                                            is_validation_label: $bankField.isValidationHidden,
//                                            is_title_label: true,
//                                            textType: .BankAccount
//                                        )
                                        
                                        TermsView(isSelected: $termsIsSelected, textColorChange: $textColorChange)
                                            .onTapGesture {
                                            termsIsSelected = !termsIsSelected
                                        }
                                    }
                                }
                    

                            }.padding(16)
                        }.mask(RoundedRectangle(cornerRadius: 0))
                    }
                    VStack {
                        ContentButtonView(title: "register_submit_button".localized) {
                            
                            var x: Bool = true
                            
                            validateField(nameField, x: &x)
                            validateField(phoneField, x: &x)
                            validateField(emailField, x: &x)
                            if !Check(fieldText: passwordField.input){
                                passwordField.isValidationHidden = false
                                x = false
                            }else{
                                passwordField.isValidationHidden = true
                            }
                            if (confirmpasswordField.input != passwordField.input || confirmpasswordField.input.isEmpty || confirmpasswordField.input == ""){
                                confirmpasswordField.isValidationHidden = false
                                x = false
                            }else{
                                confirmpasswordField.isValidationHidden = true
                            }
                            
                            if !termsIsSelected{
                                textColorChange = true
                                x = false
                            }else{
                                textColorChange = false
                            }

                            if x {
                                naviToOtp = true
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal,25)
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterVC()
}

func Check(fieldText: String) -> Bool {
    if fieldText == "" || fieldText.isEmpty{
        return false
    }else{
        return true
    }
}

func validateField(_ field: CustomTFieldState, x: inout Bool) {
    if !Check(fieldText: field.input) {
        field.isValidationHidden = false
        x = false
    }else{
        field.isValidationHidden = true
    }
}



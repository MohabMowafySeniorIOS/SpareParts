//
//  ProfileVC.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/9/25.
//

import Foundation
import SwiftUI
import PhotosUI

struct ProfileVC: View {
    @State var vv : String = ""

    @State private var selectedItem: PhotosPickerItem? = nil
 
    
    @State var isValid: Bool = true
    
    @State private var isChangePassword = false
    @Environment(\.dismiss) var dismiss
   
    @State private var isNavigating = false
    @State private var isPresented: Bool = false
    @State private var rotation: Double = 0
    @State private var isLoading = true
    @StateObject private var viewModel = ProfileViewModel()
    
    @State private var nameInput = AuthService.userData?.user?.name ?? ""
    @State private var name_title_label = "full_name".localized
    @State private var name_Validation_label = "name_required".localized
    @State private var isLabelHiddenname = true
    
    
    @State private var emailInput = AuthService.userData?.user?.email ?? ""
    @State private var email_title_label = "email".localized
    @State private var email_Validation_label = "email_required".localized
    @State private var isLabelHiddenemail = true
    
   
    
    @State private var IDInput = AuthService.userData?.user?.identityNumber ?? ""
    @State private var idValidationLabel = "id_required".localized
    @State private var isLabelHiddenID = true
    @State private var isRequiredID = true
    
    
    @State private var BankAccountInput = ""
    @State private var isLabelHiddenBankAccount = true
    @State private var bankValidationLabel = "bank_required".localized

    
    
    
    
    @State private var PhoneInput = (AuthService.userData?.user?.phone ?? "").replacingOccurrences(of: "+966", with: "")
    @State private var Phone_Validation_label = "phone_number_required".localized
    @State private var isLabelHiddenPhone = true
    
    
    @State private var ValidationErr = ""
    @State private var showAlert = false
    
    @State private var termsIsSelected = false
    @State private var showImagePicker: Bool = false
    @State private var pickedImage: UIImage? = nil
    @State private var city: Cities = .riadh
    @State private var cityTapped: Bool = false
    
    @EnvironmentObject var appState : AppState
    var body: some View {
        AppHeaderView(Title: "Profile".localized) {
            dismiss()
        }
        Spacer()

        ZStack {
            errorToast
            if viewModel.isLoading == true {
                LoaderView(rotation: $rotation, isLoading: $isLoading)
                    .frame(width: 100, height: 100)
            } else {
                mainContent
            }
        }
       
        .onReceive(viewModel.$userModel) { Model in
            guard let userData = Model else { return }
            print(userData)
            AuthService.userData?.user = userData
            appState.goToHome()
            dismiss()
        }
        .navigationDestination(isPresented: $isChangePassword) {
            ForgetPassVc()
                .navigationBarHidden(true)
        }
        Spacer()
    }
    
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
        ZStack {
            if viewModel.errorMessage != nil , viewModel.errorMessage != "" {
                ToastView(message: viewModel.errorMessage ?? "", backgroundColor: .red)
                    .transition(.move(edge: .top))
                    .zIndex(1) // To make sure the toast is above other content
            }
            if viewModel.isLoading ?? false{
                LoaderView(rotation: $rotation, isLoading: $isLoading)
                    .frame(width: 100, height: 100)
            }else {
                ZStack {
                    ScrollView {
                        VStack(spacing: 16) {
                            VStack(spacing: 51) {
                                VStack(spacing: 35) {
                                    if let selectedImage = pickedImage{
                                        ZStack(alignment:.bottomTrailing){
                                          
                                            
                                            if (AuthService.userData?.user?.profileImage ?? "") != "" {
                                                RemoteImageView(imageUrl: AuthService.userData?.user?.profileImage ?? "")
                                                   // .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 130, height: 130)
                                                    .clipShape(Circle())
                                                    .shadow(radius: 5)
                                            }else {
                                                Image(uiImage: selectedImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 130, height: 130)
                                                    .clipShape(Circle())
                                                    .shadow(radius: 5)
                                            }
                                            
                                            Image(systemName: "camera.fill.badge.ellipsis")
                                                .foregroundStyle(.main)
                                                .font(.system(size: 20))
                                                .padding(.trailing,10)
                                          
                                        }
                                            
                                    }else {
                                        ZStack(alignment: .bottomTrailing){
                                            if (AuthService.userData?.user?.profileImage ?? "") != "" {
                                                RemoteImageView(imageUrl: AuthService.userData?.user?.profileImage ?? "")
                                                   // .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 130, height: 130)
                                                    .clipShape(Circle())
                                                    .shadow(radius: 5)
                                            }else {
                                                Image.CamerICon
                                            }
                                           
                                            
                                            Image(systemName: "camera.fill.badge.ellipsis")
                                                .foregroundStyle(.main)
                                                .font(.system(size: 20))
                                                .padding(.trailing,10)
                                        }
                                            
                                    }
                                }
                                .onTapGesture {
                                    showImagePicker = true
                                }
                                .sheet(isPresented: $showImagePicker, onDismiss: {
                                    if let image = pickedImage,
                                       let imageData = image.pngData() {
                                       
                                    }
                                }) {
                                    ImageOnePicker(image: $pickedImage)
                                }
                                
                                VStack(spacing:16) {
                                    
                                    CustomTextField(text: $nameInput, Validation_label: $name_Validation_label, is_validation_label: $isLabelHiddenname, is_title_label: true, textType: .userNAme)
                                    
                                    CustomMobileTextField(text: $PhoneInput, Validation_label: $Phone_Validation_label, is_validation_label: $isLabelHiddenPhone, isPhoneNumber: true, isSelectable: false, showTitle: true, placeholder: "phone_number".localized)
                                    
                                    CustomTextField(text: $emailInput, Validation_label: $email_Validation_label, is_validation_label: $isLabelHiddenemail, is_title_label: true, textType: .Email)
                                    
                                    GenericDropdown(
                                        title: "city",
                                        selectedItem: $city,
                                        items: Cities.allCases,
                                        displayText: { $0.cityName }
                                    )

                                    CustomTextField(text: $IDInput, Validation_label: $idValidationLabel, is_validation_label: $isLabelHiddenID, is_title_label: true, textType: .Id)
                                    
                                    CustomTextField(text: $BankAccountInput, Validation_label: $bankValidationLabel, is_validation_label: $isLabelHiddenBankAccount, is_title_label: true, textType: .BankAccount)
                                    
                                  
                                }
                            }
                
                            VStack(spacing:16) {
                                ContentButtonView(title: "change_password".localized) {
                                    isChangePassword = true
                                }
                                CustomeButtonWithBorderColor(title: "save".localized) {
                                    isLabelHiddenname = false
                                    var x: Bool = true
                                    FieldChecker(text: nameInput, chVar: &x, labelHidden: &isLabelHiddenname)
                                    FieldChecker(text: PhoneInput, chVar: &x, labelHidden: &isLabelHiddenPhone)
                                    FieldChecker(text: emailInput, chVar: &x, labelHidden: &isLabelHiddenemail)
                                    FieldChecker(text: IDInput, chVar: &x, labelHidden: &isLabelHiddenID)
                                    FieldChecker(text: BankAccountInput, chVar: &x, labelHidden: &isLabelHiddenBankAccount)
                                    
                                    if x {
                                        print(nameInput,emailInput,PhoneInput)
                                        viewModel.updateProfile(profile_image: pickedImage, parameters: .init(name: nameInput,email: emailInput,phone: PhoneInput))
                                    }
                                }
                               
                            }
                        }.padding(16)
                    }.mask(RoundedRectangle(cornerRadius: 0))
                }
            }
        }
    }
}

#Preview {
    ProfileVC()
}

func FieldChecker(text: String,chVar: inout Bool,labelHidden: inout Bool) -> Bool {
    if text.isEmpty || text == "" {
        labelHidden = false
        chVar = false
    }else{
        labelHidden = true
    }
    return true
}

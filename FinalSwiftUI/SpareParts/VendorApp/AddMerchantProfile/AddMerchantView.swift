//
//  AddMerchantView.swift
//  SpareParts
//
//  Created by Mohab on 13/02/2026.
//

import Foundation
import SwiftUI

enum chooseImage {
    case logoImageSelected
    case attach1ImageSelected
    case attach2ImageSelected
    case attach3ImageSelected
    case commercialImageSelected
}

struct AddMerchantView: View {
    @State var isAddedAddressBar: Bool = false
    
    @State private var logoImage: UIImage? = nil
    @State private var attach1Image: UIImage? = nil
    @State private var attach2Image: UIImage? = nil
    @State private var attach3Image: UIImage? = nil
    @State private var commercialImage: UIImage? = nil
    
    @State private var selectedImage: chooseImage? = nil // <-- FIXED HERE
    
    @State private var pickedImage: UIImage? = nil
    @State var currentImage: String?
    @State private var pickedImages: [VendorImage] = []
    @State private var isImagePickerValid: Bool = true
    
    @State private var arabicAboutBody : String = ""
    @State private var isarabicAboutBodyFieldValid: Bool = true
    
    @State private var englishAboutBody : String = ""
    @State private var isenglishAboutBodyFieldValid: Bool = true
    
    @StateObject var arabiNameField            = CustomTFieldState(validationLabel: "validation_required".localized)
    
    @StateObject var EnglishnameField            = CustomTFieldState(validationLabel: "validation_required".localized)
    
    @StateObject var BanknameField            = CustomTFieldState(validationLabel: "validation_required".localized)
    
    @StateObject var CommercialNumberField            = CustomTFieldState(validationLabel: "validation_required".localized)
  
    @StateObject var BenefetaryNumberField            = CustomTFieldState(validationLabel: "validation_required".localized)
    
    @StateObject var AccountNumberField            = CustomTFieldState(validationLabel: "validation_required".localized)
    
    
    @StateObject var IBANNumberField            = CustomTFieldState(validationLabel: "validation_required".localized)
   
    
    @State private var showImagePicker: Bool = false
    
    @State private var termsIsSelected = false
    
    @State private var naviToOtp: Bool = false
    @State private var checkboxalert: Bool = false
    @State private var textColorChange: Bool = false
    
    @State var is_country_validation_label: Bool = true
    @State var Validation_country_label: String = "Country Is Required".localized
    
    @State var is_city_validation_label: Bool = true
    @State var Validation_city_label: String = "City Is Required".localized
    
    
    @State private var showErrors = false
    
    @State var isTerms: Bool = false
    @State var termsMandatory: Bool = false
    
   @ObservedObject var viewModel: AddMerchantViewModel
    init(viewModel: AddMerchantViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            AppHeaderView(Title: "commercial_request_title") {
                viewModel.coordinator.disMiss()
            }
            scrollView
            Spacer()
            updateButton
        }
        .background(Color.backGroundColor)
        .sheet(isPresented: $showImagePicker, onDismiss: {
            if let image = pickedImage {
                
                if selectedImage == .logoImageSelected {
                    self.logoImage = image
                }else if selectedImage == .attach1ImageSelected {
                    self.attach1Image = image
                }else if selectedImage == .attach2ImageSelected {
                    self.attach2Image = image
                }else if selectedImage == .attach3ImageSelected {
                    self.attach3Image = image
                }
                else if selectedImage == .commercialImageSelected {
                    self.commercialImage = image
                }
               
            }
        }) {
            ImageOnePicker(image: $pickedImage)
        }
    }
    
    private var scrollView: some View {
        ScrollView {
            VStack(spacing: 16) {
                textFields
            }
            .padding()
        }
    }
    
    private var textFields: some View {
        VStack(spacing:16) {
            
            CustomTextField(
                text: $arabiNameField.input,
                Validation_label: $arabiNameField.validationLabel,
                is_validation_label: $arabiNameField.isValidationHidden,
                is_title_label: true,
                textType: .arabicTraderName
            )
            
            CustomTextField(
                text: $EnglishnameField.input,
                Validation_label: $EnglishnameField.validationLabel,
                is_validation_label: $EnglishnameField.isValidationHidden,
                is_title_label: true,
                textType: .englishTraderName
            )
            imagesView
            UploadImagesView(logoImage: $logoImage, attach1Image: $attach1Image, attach2Image: $attach2Image, attach3Image: $attach3Image,logoAction: {
               selectedImage = .logoImageSelected
                showImagePicker = true
            }, attach1: {
              selectedImage = .attach1ImageSelected
                showImagePicker = true
            }, attach2: {
                selectedImage = .attach2ImageSelected
                showImagePicker = true
            }, attach3: {
                selectedImage = .attach3ImageSelected
                showImagePicker = true
            })
            arabicAbouttextView
            englishAbouttextView
        
            GenericDropdown(
                title: "country".localized,
                is_validation_label: $is_country_validation_label, Validation_label: $Validation_country_label,
                selectedItem: $viewModel.selectedCcountry,
                items: viewModel.countryArray,
                displayText: { $0.name ?? ""
                }
            )
            
            GenericDropdown(
                title: "city".localized,
                is_validation_label: $is_city_validation_label, Validation_label: $Validation_city_label,
                selectedItem: $viewModel.selectedCity,
                items: viewModel.cityArray,
                displayText: { $0.name ?? "" }
            )
            
            addAddressView
            
            CustomTextField(
                text: $CommercialNumberField.input,
                Validation_label: $CommercialNumberField.validationLabel,
                is_validation_label: $CommercialNumberField.isValidationHidden,
                is_title_label: true,
                textType: .commercialNumber
            )
            VStack {
                HStack {
                    CustomLabel_text(imageName: "", labelText: "Attach a copy of the commercial registration.".localized)
                    Spacer()
                }
                UploadBox(size: 201, image: $commercialImage)
                    .onTapGesture {
                       selectedImage = .commercialImageSelected
                        showImagePicker = true
                }
            }
           
            CustomTextField(
                text: $BanknameField.input,
                Validation_label: $BanknameField.validationLabel,
                is_validation_label: $BanknameField.isValidationHidden,
                is_title_label: true,
                textType: .BankName
            )
            
            CustomTextField(
                text: $AccountNumberField.input,
                Validation_label: $AccountNumberField.validationLabel,
                is_validation_label: $AccountNumberField.isValidationHidden,
                is_title_label: true,
                textType: .BankAccount
            )
            
            CustomTextField(
                text: $BenefetaryNumberField.input,
                Validation_label: $BenefetaryNumberField.validationLabel,
                is_validation_label: $BenefetaryNumberField.isValidationHidden,
                is_title_label: true,
                textType: .benefiterName
            )
            
            CustomTextField(
                text: $IBANNumberField.input,
                Validation_label: $IBANNumberField.validationLabel,
                is_validation_label: $IBANNumberField.isValidationHidden,
                is_title_label: true,
                textType: .IBAN
            )
         
        
        }
    }
    @ViewBuilder
    private var imagesView: some View {
        if let image = currentImage {
            RemoteImageView(imageUrl: image)
                .frame(width: 200, height: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.SecondaryColor, lineWidth: 2)
                )
                .clipped()
                .cornerRadius(14)
                .padding(.bottom,10)
        }
        HorizontalImageScroller(images: pickedImages, currentImage: $currentImage)
    }
  
    @ViewBuilder
    private var addAddressView: some View {
        AddedCarSelectionBar(
            title: "added_address_menu".localized,
            isClicked: $isAddedAddressBar
        ) {
            viewModel.coordinator.showAddAddresses(addressModel: nil)
        }
        .padding(.trailing)
        if isAddedAddressBar {
            ForEach(viewModel.myAddresses.indices, id: \.self) { index in
                let item = viewModel.myAddresses[index]
                CreateOrderSelectionBar(
                    isChecked: item.id == viewModel.selectedAddresses?.id, title: item.address_text ?? "",
                    imageName: "mappin.and.ellipse"
                )
                .onTapGesture {
                    viewModel.selectedAddresses = viewModel.myAddresses[index]
                }
            }
        }
    }
    
    private var updateButton: some View {
        ContentButtonView(title: "register_submit_button".localized) {
            if isValid() {
                viewModel.completeProfile(parameters: .init(full_name: "\(viewModel.selectedCity?.id ?? 0)", email: "\(viewModel.selectedAddresses?.latitude ?? 0.0)",phone: "\(viewModel.selectedAddresses?.longitude ?? 0.0)", city_id: BanknameField.input, auth: arabiNameField.input,code: EnglishnameField.input,current_password: arabicAboutBody,password: englishAboutBody,password_confirmation: "\(viewModel.selectedCcountry?.id ?? 0)",method: viewModel.selectedAddresses?.address_text ?? "",device_token: Helper.getFcmtoken() ?? "", type: BanknameField.input, agree_terms: "\(viewModel.selectedAddresses?.id ?? 0)",car_category_id:AccountNumberField.input,bank_iban:IBANNumberField.input))
            }
        }.padding()
    }
    
    private var tesrmsView: some View {
        TermsView(
            isSelected: $isTerms, textColorChange: $termsMandatory
        )
        .onTapGesture {
            isTerms.toggle()
        }
    }
    
    private var arabicAbouttextView: some View {
        VStack(alignment: .trailing, spacing: 8) {
            HStack {
                Text("About the Commercial (in Arabic)".localized)
                    .font(addFont(fontType: .bold, size: 12))
                Spacer()
            }
            
            TextEditor(text: $arabicAboutBody)
                .frame(height: 120)
                .scrollContentBackground(.hidden)
                    .background(Color.CWhite)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
            
            
            if !isarabicAboutBodyFieldValid {
                HStack{
                    Text("validation_required".localized)
                        .font(addFont(fontType: .bold, size: 12))
                        .foregroundStyle(Color.CRed)
                    
                    Spacer()
                }
            }
        }
    }
    
    private var englishAbouttextView: some View {
        VStack(alignment: .trailing, spacing: 8) {
            HStack {
                Text("About the business (in English)".localized)
                    .font(addFont(fontType: .bold, size: 12))
                Spacer()
            }
            
            TextEditor(text: $englishAboutBody)
                .frame(height: 120)
                .scrollContentBackground(.hidden)   // مهم
                    .background(Color.CWhite)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
            
            
            if !isenglishAboutBodyFieldValid {
                HStack{
                    Text("validation_required".localized)
                        .font(addFont(fontType: .bold, size: 12))
                        .foregroundStyle(Color.CRed)
                    
                    Spacer()
                }
            }
        }
    }
    
    func isValid() -> Bool {
        var x: Bool = true
        
        validateField(arabiNameField,  x: &x)
        validateField(EnglishnameField,  x: &x)
        validateField(BanknameField,  x: &x)
        validateField(AccountNumberField,  x: &x)
        validateField(BenefetaryNumberField,  x: &x)
        validateField(IBANNumberField,  x: &x)
     
        if !Check(fieldText: viewModel.selectedCcountry?.name ?? ""){
            is_country_validation_label = false
          
        }else{
            is_country_validation_label = true
        }
        if !Check(fieldText: viewModel.selectedCity?.name ?? ""){
            is_city_validation_label = false
          
        }else{
            is_city_validation_label = true
        }
        
        if !Check(fieldText: arabicAboutBody){
            isarabicAboutBodyFieldValid = false
          
        }else{
            isarabicAboutBodyFieldValid = true
        }
        if !Check(fieldText: englishAboutBody){
            isenglishAboutBodyFieldValid = false
          
        }else{
            isenglishAboutBodyFieldValid = true
        }
       
        
        if !termsIsSelected{
            textColorChange = true
            x = false
        }else{
            textColorChange = false
        }
        
        
        return x
    }
    
}
struct InputField: View {
    
    let title: LocalizedStringKey
    @Binding var text: String
    var showError: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(title, text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(showError ? Color.red : Color.gray.opacity(0.3))
                )
                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)

            if showError {
                Text("validation_required")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}
struct MultilineField: View {
    
    let title: LocalizedStringKey
    @Binding var text: String
    var showError: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            ZStack(alignment: .topLeading) {
                
                TextEditor(text: $text)
                    .frame(height: 120)
                    .padding(4)
                    .background(Color.white)
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(showError ? Color.red : Color.gray.opacity(0.3))
                    )
                    .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)

                if text.isEmpty {
                    Text(title)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
            }
            
            if showError {
                Text("validation_required")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}
import SwiftUI

struct UploadImagesView: View {
    @Binding var logoImage: UIImage?
    @Binding var attach1Image: UIImage?
    @Binding var attach2Image: UIImage?
    @Binding var attach3Image: UIImage?
    var logoAction:()->Void
    var attach1:()->Void
    var attach2:()->Void
    var attach3:()->Void
  
    var body: some View {
        VStack(alignment: .trailing, spacing: 24) {
            
            HStack {
                CustomLabel_text(imageName: "", labelText: "Attach Logo".localized)
                Spacer()
            }
            
            UploadBox(size: 106, image: $logoImage)
                .onTapGesture {
                    logoAction()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            HStack {
                CustomLabel_text(imageName: "", labelText: "Attach Added Images".localized)
                Spacer()
            }
            
            
            // MARK: - Extra Images Grid
            HStack(spacing: 16) {
                UploadBox(size: 106, image: $attach1Image)
                    .onTapGesture {
                        attach1()
                    }
                UploadBox(size: 106, image: $attach2Image)
                    .onTapGesture {
                        attach2()
                    }
                UploadBox(size: 106, image: $attach3Image)
                    .onTapGesture {
                        attach3()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        
        .background(Color(Color.backGroundColor))
    }
}
struct UploadBox: View {
    
    let size: CGFloat
    @Binding var image: UIImage?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                )
                .frame(width: size, height: size)
            
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: size * 0.28)
                .foregroundColor(.cyan)
            
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: size, height: size)
                    .cornerRadius(16)
                    .scaledToFit()
                
            }
        }
    }
}


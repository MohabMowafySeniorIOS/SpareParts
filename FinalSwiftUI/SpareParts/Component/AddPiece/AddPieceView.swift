//  AddPieceView.swift
//  MyAuctions
//  Created by Mohab Mowafy on 17/07/2025.

import SwiftUI

enum RequiredPieceType: String {
    case original = "new_original"
    case wekala = "new_agency"
    case usedLocal = "used_local"
    case usedForeign = "used_import"
}

struct AddPieceView: View {
    @Environment(\.dismiss) var dismiss
    @Binding  var partsPiece: [PartModel]
    @Binding var selectedPartIndex: Int?
    
    @State private var pieceNameFieldText: String = ""
    @State private var isPieceNameFieldValid: Bool = true
    @State private var pieceNumFieldText: String = ""
    @State private var isPieceNumFieldValid: Bool = true
    @State private var pieceCountFieldText: String = ""
    @State private var isPieceCountFieldValid: Bool = true
    @State private var showImagePicker: Bool = false
    @State private var isImagePickerValid: Bool = true
    @State private var requiredPieceType: RequiredPieceType = .original
    @State private var requiredPieceTypeText: String = "new (original)".localized
    @State private var descriptionText: String = ""
    @State private var isDescribtionFieldValid: Bool = true
    
    @ObservedObject private var viewModel: AddPieceViewModel
    
    init(viewModel: AddPieceViewModel, partsPiece: Binding<[PartModel]>,selectedPartIndex:Binding<Int?>) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self._partsPiece = partsPiece
        self._selectedPartIndex = selectedPartIndex
        
       
       
    }
    
    var body: some View {
        
        mainContent
            .navigationBarHidden(true)
            .onAppear {
                if let selectedPartIndex = self.selectedPartIndex {
                    print(selectedPartIndex,partsPiece)
                    self.pieceNameFieldText = self.partsPiece[selectedPartIndex].name
                    self.pieceNumFieldText = self.partsPiece[selectedPartIndex].number.toEnglishDigits()
                    self.pieceCountFieldText = self.partsPiece[selectedPartIndex].quantity.toEnglishDigits()
                    viewModel.pickedImages = self.partsPiece[selectedPartIndex].uploadPickedImages
                    if self.partsPiece[selectedPartIndex].type == "new_original" {
                        self.requiredPieceType = .original
                        self.requiredPieceTypeText = "new (original)".localized
                    }else if self.partsPiece[selectedPartIndex].type == "new_agency" {
                        self.requiredPieceType = .wekala
                        self.requiredPieceTypeText = "new (wekala)".localized
                    }else if self.partsPiece[selectedPartIndex].type == "used_local" {
                        self.requiredPieceType = .usedLocal
                        self.requiredPieceTypeText = "used (local)".localized
                    }else if self.partsPiece[selectedPartIndex].type == "used_import" {
                        self.requiredPieceType = .usedForeign
                        self.requiredPieceTypeText = "user (foreign)".localized
                    }
                   
                    self.descriptionText = self.partsPiece[selectedPartIndex].describtion
                    
                }
            }
        
    }
    
    var mainContent: some View {
        VStack {
           
            
            AppHeaderView(Title: "add_piece".localized) {
                dismiss()
            }
            ShowViewState(state: viewModel.state) { Model in
                VStack {
                    scrollView
                    addPieceButton
                }
            }
            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(onImagesPicked: { image in
                let maxImages = 4
                if viewModel.pickedImages.count < maxImages {
                    
                    Task {
                        await uploadAllImages(images: image)
                    }
                    
                }
            },selectionLimit: 4-viewModel.pickedImages.count)
        }
    }
    
    func uploadAllImages(images: [UIImage]) async {
        await withTaskGroup(of: Void.self) { group in
            
            for image in images {
                group.addTask {
                    await self.viewModel.attachMents(file: image, parameters: .init(media_type:"image",model: "OrderItem",option: "order_item_images",is_single: "0"))
                }
            }
            
            await group.waitForAll()
            print("✅ All uploads finished")
        }
    }
    
    var scrollView: some View {
      
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                textFields
                peiceImages
                pieceType
                describtionView
            }
        }
        .padding(.horizontal)

    }
    
    @ViewBuilder
    var textFields: some View {
        
            SpareTextFieldWithLabel(
                text: $pieceNameFieldText,
                is_validation_label: $isPieceNameFieldValid,
                is_title_label: true, fieldtype: .constant(.pieceName))

            SpareTextFieldWithLabel(
                text: $pieceNumFieldText,
                is_validation_label: $isPieceNumFieldValid,
                is_title_label: true, fieldtype: .constant(.PieceNum))

            SpareTextFieldWithLabel(
                text: $pieceCountFieldText,
                is_validation_label: $isPieceCountFieldValid,
                is_title_label: true, fieldtype: .constant(.pieceCount))
    }
  
    @ViewBuilder
    private var pieceType: some View {
        TitleLabel(title: "required_piece_type".localized)

        HStack {
            SelectorBarCustomView(
                title: "new (original)".localized,
                isSelected: requiredPieceType == .original
            )
            .onTapGesture {
                self.requiredPieceTypeText = "new (original)".localized
                requiredPieceType = .original
            }
           
            
            SelectorBarCustomView(title: "new (wekala)".localized, isSelected: requiredPieceType == .wekala)
                .onTapGesture {
                    self.requiredPieceTypeText = "new (wekala)".localized
                     requiredPieceType = .wekala
                }
        }
        SelectorBarCustomView(title: "used (local)".localized, isSelected: requiredPieceType == .usedLocal)
            .onTapGesture {
                requiredPieceType = .usedLocal
                self.requiredPieceTypeText = "used (local)".localized
            }
        
        SelectorBarCustomView(title: "user (foreign)".localized, isSelected: requiredPieceType == .usedForeign)
            .onTapGesture {
                self.requiredPieceTypeText = "user (foreign)".localized
                requiredPieceType = .usedForeign
            }
    }
    
    @ViewBuilder
    private var peiceImages: some View {
        HStack {
            TitleLabel(title: "add_piece_images".localized)
            Spacer()
            Image("Add photo")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.MainColor)
                .onTapGesture {
                    if viewModel.pickedImages.count < 4 {
                        showImagePicker = true
                    }
                }
        }

        ImagePickerAndSlider(pickedImages: $viewModel.pickedImages,is_validation_label: $isImagePickerValid)
    }
    
    @ViewBuilder
    private var describtionView: some View {
        TitleLabel(title: "add_text_description".localized)
        
        VStack(spacing: 8) {
            TextEditor(text: $descriptionText)
                .frame(height: 100)
                .padding(8)
                .scrollContentBackground(.hidden)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.CWhite)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemTeal), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
                .padding(1)
                .multilineTextAlignment(.trailing)
                .environment(\.layoutDirection, .rightToLeft)
            
            if !isDescribtionFieldValid {
                HStack{
                    Text("Please Insert Describtion".localized)
                        .font(addFont(fontType: .bold, size: 12))
                        .foregroundStyle(Color.CRed)
                    
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    private var addPieceButton: some View {
        SimpleSpareButton(buttonTitle: "add_piece".localized, action: {
            if isValid(){
                if let selectedPartIndex = selectedPartIndex  {
                    print(requiredPieceTypeText)
                    partsPiece[selectedPartIndex] = PartModel(name: pieceNameFieldText, number: pieceNumFieldText, type: requiredPieceType.rawValue, quantity: pieceCountFieldText, describtion: descriptionText, uploadPickedImages: viewModel.pickedImages, typeName: requiredPieceTypeText)
                }else {
                    print(requiredPieceTypeText)
                    partsPiece.append(PartModel(name: pieceNameFieldText, number: pieceNumFieldText, type: requiredPieceType.rawValue, quantity: pieceCountFieldText, describtion: descriptionText, uploadPickedImages: viewModel.pickedImages, typeName: requiredPieceTypeText))
                }
             
                dismiss()
            }
           
        }, widthValue: 300, heightValue: 45)
        .padding(.top)
    }
   
    func isValid() -> Bool {
        var x: Bool = true
        FieldChecker(text: pieceNameFieldText, chVar: &x, labelHidden: &isPieceNameFieldValid)
        FieldChecker(text: pieceNumFieldText, chVar: &x, labelHidden: &isPieceNumFieldValid)
        FieldCheckerGreaterThanZero(text: pieceCountFieldText, chVar: &x, labelHidden: &isPieceCountFieldValid)
        
        FieldChecker(text: descriptionText, chVar: &x, labelHidden: &isDescribtionFieldValid)
        
        if viewModel.pickedImages.count == 0 {
            x = false
            isImagePickerValid = false
        }else {
            isImagePickerValid = true
        }
      
       
        return x
    }
}

extension String {

    func toEnglishDigits() -> String {

        let arabicNumbers = [
            "٠": "0", "١": "1", "٢": "2", "٣": "3", "٤": "4",
            "٥": "5", "٦": "6", "٧": "7", "٨": "8", "٩": "9"
        ]

        let persianNumbers = [
            "۰": "0", "۱": "1", "۲": "2", "۳": "3", "۴": "4",
            "۵": "5", "۶": "6", "۷": "7", "۸": "8", "۹": "9"
        ]

        var result = self

        arabicNumbers.forEach {
            result = result.replacingOccurrences(of: $0.key, with: $0.value)
        }

        persianNumbers.forEach {
            result = result.replacingOccurrences(of: $0.key, with: $0.value)
        }

        return result
    }
}

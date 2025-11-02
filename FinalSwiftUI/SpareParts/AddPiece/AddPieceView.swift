//  AddPieceView.swift
//  MyAuctions
//  Created by Moaaz Ahmed on 17/07/2025.

import SwiftUI

enum RequiredPieceType {
    case original
    case wekala
    case usedLocal
    case usedForeign
}

struct AddPieceView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var pieceNameFieldText: String = ""
    @State private var isPieceNameFieldValid: Bool = true
    @State private var pieceNumFieldText: String = ""
    @State private var isPieceNumFieldValid: Bool = true
    @State private var pieceCountFieldText: String = ""
    @State private var isPieceCountFieldValid: Bool = true
    @State private var pickedImages: [UIImage] = []
    @State private var showImagePicker: Bool = false
    @State private var requiredPieceType: RequiredPieceType = .original
    @State private var descriptionText: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                
                NormalAppBar(title: "add_piece_title") {
                    dismiss()
                }
                ScrollView(showsIndicators: false) {

                    VStack(spacing: 20) {
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

                        HStack {
                            TitleLabel(title: "add_piece_images")
                            Spacer()
                            Image(systemName: "photo.on.rectangle.angled.fill")
                                .foregroundStyle(.main)
                                .onTapGesture {
                                    showImagePicker = true
                                }
                        }

                        ImagePickerAndSlider(pickedImages: $pickedImages)

                        TitleLabel(title: "required_piece_type")

                        HStack {
                            SelectorBarCustomView(
                                title: "new (original)",
                                isSelected: requiredPieceType == .original
                            )
                            .onTapGesture {
                                requiredPieceType = .original
                            }
                            
                            SelectorBarCustomView(title: "new (wekala)", isSelected: requiredPieceType == .wekala)
                                .onTapGesture {
                                     requiredPieceType = .wekala
                                }
                        }
                        SelectorBarCustomView(title: "used (local)", isSelected: requiredPieceType == .usedLocal)
                            .onTapGesture {
                                requiredPieceType = .usedLocal
                            }
                        
                        SelectorBarCustomView(title: "user (foreign)", isSelected: requiredPieceType == .usedForeign)
                            .onTapGesture {
                                requiredPieceType = .usedForeign
                            }
                        
                        TitleLabel(title: "add_text_description")
                        
                        VStack(spacing: 8) {
                            TextEditor(text: $descriptionText)
                                .frame(height: 100)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemTeal), lineWidth: 1)
                                )
                                .padding(1)
                                .multilineTextAlignment(.trailing)
                                .environment(\.layoutDirection, .rightToLeft)
                        }
                        
                        SimpleSpareButton(buttonTitle: "add_piece", action: {
                            
                        }, widthValue: 300, heightValue: 45)
                        .padding(.top)
                    }

                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(onImagesPicked: { image in
                let maxImages = 4
                if pickedImages.count < maxImages {
                    pickedImages.append(contentsOf: image)
                }
            })
        }
    }
}

#Preview {
    AddPieceView()
}

 

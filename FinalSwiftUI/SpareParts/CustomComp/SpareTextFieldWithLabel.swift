//
//  SpareTextFieldWithLabel.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 17/07/2025.
//

import SwiftUI

enum TextFieldType {
    case pieceName
    case PieceNum
    case pieceCount
}

struct SpareTextFieldWithLabel: View {
    
    @Binding var text: String
    @State var title_label: String = ""
    @State var Validation_label: String = ""
    @Binding var is_validation_label: Bool
    @State var is_title_label: Bool
    @State private var isEditing = false
    @State var placeholder: String = ""
    @Binding var fieldtype: TextFieldType?
    
    var body: some View {
        VStack(spacing:4) {
            VStack(spacing:8) {
                HStack {
                    CustomLabel_text(imageName: title_label, labelText: title_label)
                    Spacer()
                }
                ZStack {
                    TextField(placeholder, text: $text, onEditingChanged: { editing in
                        isEditing = editing})
                    .keyboardType(.default)
                    .padding()
                    .frame(height: 43)
                    .background((isEditing || !text.isEmpty) ? Color.clear : Color.clear) // Change
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke((isEditing || !text.isEmpty) ? Color.MainColor : Color.TextBorderColor, lineWidth: 1))
                    .padding(1)
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
        }
        .onAppear {
            switch fieldtype {
            case .pieceName:
                self.title_label = "piece_name"
                self.$Validation_label.wrappedValue = "Please enter a valid piece name."
                self.placeholder = "Enter Piece Name"
                
            case .PieceNum:
                self.title_label = "piece_number"
                self.$Validation_label.wrappedValue = "Please enter a valid piece number."
                self.placeholder = "Enter Piece number"
                
            case .pieceCount:
                self.title_label = "Piece Count"
                self.$Validation_label.wrappedValue = "Please enter a valid piece Count."
                self.placeholder = "Enter Piece Count"
                
            default:
                break
            }
        }
    }
}
    


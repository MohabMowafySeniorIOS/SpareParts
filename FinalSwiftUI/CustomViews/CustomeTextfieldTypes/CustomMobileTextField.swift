//
//  CustomMobileTextField.swift
//  FinalSwiftUI
//  Created by Mohab on 15/05/2025.
//
import Foundation
import SwiftUI

struct CustomMobileTextField: View {
    @Binding var text: String
    @Binding var Validation_label: String
    @Binding var is_validation_label: Bool
    @State var isPhoneNumber: Bool
    @State private var isEditing = false
    @State var isSelectable: Bool
    @State var showTitle: Bool
    var placeholder: String

    var body: some View {
        VStack(spacing: 4) {
            VStack(spacing: 8) {
                if showTitle {
                    HStack {
                        CustomLabel_text(
                            imageName: "", labelText: "phone_number".localized)
                        Spacer()
                    }
                }
                ZStack {
                    TextField(
                        placeholder.localized, text: $text,
                        onEditingChanged: { editing in
                            isEditing = editing
                        }
                    )
                    .onChange(of: text) { newValue in
                        text = filterPhoneNumber(newValue)
                    }
                    .keyboardType(.phonePad)
                    .padding()
                    .frame(height: 48)
                    .background(
                        (isEditing || !text.isEmpty) ? Color.clear : Color.clear
                    )  // Change
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(
                            (isEditing || !text.isEmpty)
                                ? Color.MainColor : Color.TextBorderColor,
                            lineWidth: 1))
                    HStack {
                        Spacer()
                        HStack {
                            Text("")
                                .frame(width: 1, height: 33)
                                .background(Color.TextBorderColor)

                            Text("+9665").foregroundColor(Color.TextBorderColor)
                        }
                    }.padding()
                }.environment(\.layoutDirection, .leftToRight)
                // Optional: You can add more customizations like error messages or icons here.
            }
            if !is_validation_label {
                CustomValidationLabel(
                    imageName: "star.fill",
                    labelText: Validation_label.localized)
            }
        }
    }

    private func filterPhoneNumber(_ input: String) -> String {
        let filtered = input.filter { "0123456789".contains($0) }
        return String(filtered.prefix(10))
    }
}

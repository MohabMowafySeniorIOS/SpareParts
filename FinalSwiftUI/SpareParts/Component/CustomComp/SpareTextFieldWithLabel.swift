//
//  SpareTextFieldWithLabel.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 17/07/2025.
//

import SwiftUI
import UIKit

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
    @State var keyBoardType: UIKeyboardType = .default

    var body: some View {

        VStack(spacing: 4) {

            VStack(spacing: 8) {

                HStack {

                    CustomLabel_text(
                        imageName: title_label,
                        labelText: title_label
                    )

                    Spacer()
                }


                // MARK: UIKit TextField

                SpareUIKitTextField(
                    text: $text,
                    placeholder: placeholder,
                    keyboardType: keyBoardType,
                    isEditing: $isEditing
                )
                .frame(height: 43)
                .padding(.horizontal, 12)
                .background(Color.CWhite)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            (
                                isEditing ||
                                !text.isEmpty
                            )
                            ? Color.MainColor
                            : Color.TextBorderColor,
                            lineWidth: 1
                        )
                )
                .shadow(
                    color: Color.black.opacity(0.06),
                    radius: 6,
                    x: 0,
                    y: 2
                )
                .padding(1)


                // MARK: Validation

                if !is_validation_label {

                    HStack {

                        Text(
                            Validation_label.localized
                        )
                        .font(
                            addFont(
                                fontType: .bold,
                                size: 12
                            )
                        )
                        .foregroundStyle(
                            Color.CRed
                        )

                        Spacer()
                    }
                }
            }
        }

        .onAppear {

            configureField()
        }

        .onChange(of: fieldtype) { _ in

            configureField()
        }
    }


    // MARK: - Configure Field

    private func configureField() {

        switch fieldtype {

        case .pieceName:

            title_label =
                "Piece Name".localized

            Validation_label =
                "Please enter a valid piece name.".localized

            placeholder =
                "Enter Piece Name".localized

            keyBoardType =
                .default


        case .PieceNum:

            title_label =
                "Piece Number".localized

            Validation_label =
                "Please enter a valid piece number.".localized

            placeholder =
                "Enter Piece number".localized

            keyBoardType =
                .default


        case .pieceCount:

            title_label =
                "Piece Count".localized

            Validation_label =
                "Please enter a valid piece Count.".localized

            placeholder =
                "Enter Piece Count".localized

            keyBoardType =
                .numberPad


        default:

            break
        }
    }
}


// MARK: - UIKit TextField

struct SpareUIKitTextField: UIViewRepresentable {

    @Binding var text: String

    let placeholder: String
    let keyboardType: UIKeyboardType

    @Binding var isEditing: Bool


    // MARK: Make UIView

    func makeUIView(
        context: Context
    ) -> UITextField {

        let textField = UITextField()

        textField.delegate =
            context.coordinator

        textField.text =
            text

        textField.placeholder =
            placeholder

        textField.textColor =
            UIColor(Color.CBlack)

        textField.tintColor =
            UIColor(Color.MainColor)

        textField.backgroundColor =
            .clear

        textField.borderStyle =
            .none

        textField.font =
            UIFont.systemFont(
                ofSize: 17
            )

        textField.keyboardType =
            keyboardType


        // MARK: Direction

        if isArabic {

            textField.textAlignment =
                .right

            textField.semanticContentAttribute =
                .forceRightToLeft

        } else {

            textField.textAlignment =
                .left

            textField.semanticContentAttribute =
                .forceLeftToRight
        }


        // MARK: Editing Events

        textField.addTarget(
            context.coordinator,
            action: #selector(
                Coordinator.editingDidBegin(_:)
            ),
            for: .editingDidBegin
        )

        textField.addTarget(
            context.coordinator,
            action: #selector(
                Coordinator.editingDidEnd(_:)
            ),
            for: .editingDidEnd
        )

        return textField
    }


    // MARK: Update UIView

    func updateUIView(
        _ uiView: UITextField,
        context: Context
    ) {

        /*
         IMPORTANT:

         Don't update text while user
         is currently typing.

         Otherwise the cursor can jump
         and the entered text may not
         appear immediately.
        */

        if !uiView.isFirstResponder &&
            uiView.text != text {

            uiView.text =
                text
        }


        if uiView.placeholder != placeholder {

            uiView.placeholder =
                placeholder
        }


        if uiView.keyboardType != keyboardType {

            uiView.keyboardType =
                keyboardType

            if uiView.isFirstResponder {

                uiView.reloadInputViews()
            }
        }


        // MARK: Direction

        if isArabic {

            uiView.textAlignment =
                .right

            uiView.semanticContentAttribute =
                .forceRightToLeft

        } else {

            uiView.textAlignment =
                .left

            uiView.semanticContentAttribute =
                .forceLeftToRight
        }
    }


    // MARK: Coordinator

    func makeCoordinator()
        -> Coordinator {

        Coordinator(self)
    }


    final class Coordinator:
        NSObject,
        UITextFieldDelegate {

        var parent:
            SpareUIKitTextField


        init(
            _ parent:
                SpareUIKitTextField
        ) {

            self.parent =
                parent
        }


        // MARK: Editing Begin

        @objc
        func editingDidBegin(
            _ textField: UITextField
        ) {

            parent.isEditing =
                true
        }


        // MARK: Editing End

        @objc
        func editingDidEnd(
            _ textField: UITextField
        ) {

            parent.isEditing =
                false
        }


        // MARK: Text Change

        func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String
        ) -> Bool {

            guard
                let currentText =
                    textField.text,

                let textRange =
                    Range(
                        range,
                        in: currentText
                    )
            else {

                return false
            }


            let updatedText =
                currentText.replacingCharacters(
                    in: textRange,
                    with: string
                )


            // Convert Arabic numbers
            // to English numbers

            let normalizedText =
                updatedText.toEnglishDigits()


            // Update SwiftUI Binding

            parent.text =
                normalizedText


            /*
             IMPORTANT:

             Return true when the text
             does not need normalization.

             Return false when we need
             to manually update UITextField.
            */

            if normalizedText != updatedText {

                textField.text =
                    normalizedText

                return false
            }


            return true
        }
    }
}

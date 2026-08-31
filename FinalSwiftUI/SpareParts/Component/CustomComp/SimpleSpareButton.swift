//
//  SimpleSpareButton.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 16/07/2025.
//

import SwiftUI
struct SimpleSpareButton: View {
    
    var buttonTitle: String
    var action: () -> Void
    var widthValue: CGFloat
    var heightValue: CGFloat

    var body: some View {
        Button {
            action()
        } label: {
            Group {
                if widthValue.isInfinite {
                    Text(buttonTitle.localized)
                        .frame(maxWidth: .infinity)
                } else {
                    Text(buttonTitle.localized)
                        .frame(width: widthValue)
                }
            }
            .font(.custom(AppFont.bold.rawValue, size: 16))
            .foregroundStyle(Color.CWhite)
            .frame(height: heightValue)
            .background(
                Color.MainColor
                    .cornerRadius(20)
            )
        }

    }
}

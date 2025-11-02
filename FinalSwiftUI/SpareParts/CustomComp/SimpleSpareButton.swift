//
//  SimpleSpareButton.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 16/07/2025.
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
            Text(buttonTitle.localized)
                .foregroundStyle(.cWhite)
                .frame(width: widthValue, height: heightValue)
                .background(
                    Color.main
                        .cornerRadius(20)
                )
        }

    }
}

//
//  HomeOrderTypeButton.swift
//  MyAuctions
//
//  Created by Mohab on 10/07/2025.
//
import SwiftUI

struct HomeOrderTypeButton: View {
    var title: String
    var action: () -> Void
    var bgColor: Color
    var textColor: Color
    var body: some View {
        Text(title.localized)
            .font(.custom(AppFont.bold.rawValue, size: 16))
            .foregroundStyle(textColor)
            .frame(width: 120,height: 50)
            .background(bgColor)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.MainColor, lineWidth: 1.5)
            )
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
            .onTapGesture {
                action()
            }
    }
}

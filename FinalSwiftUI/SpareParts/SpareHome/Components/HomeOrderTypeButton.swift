//
//  HomeOrderTypeButton.swift
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
//
import SwiftUI

struct HomeOrderTypeButton: View {
    var title: String
    var action: () -> Void
    var bgColor: Color
    var textColor: Color
    var body: some View {
        Text(title.localized)
            .foregroundStyle(textColor)
            .frame(width: 120,height: 50)
            .background(bgColor)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 3))
                    .fill(.main)
            )
            .cornerRadius(10)
            .onTapGesture {
                action()
            }
    }
}

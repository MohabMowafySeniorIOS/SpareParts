//
//  TitleLabel.swift
//  MyAuctions
//
//  Created by Mohab on 10/07/2025.
//
import SwiftUI

struct TitleLabel: View {
    var title: String
    var body: some View {
        HStack(spacing: 6) {
            Text(title.localized)
                .foregroundStyle(Color.SecondaryColor)
                .font(addFont(fontType: .bold, size: 16))

            Rectangle()
                .fill(Color.MainColor)
                .frame(width: 3, height: 16)
                .cornerRadius(2)

            Spacer()
        }
    }
}

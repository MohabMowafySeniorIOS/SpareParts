//
//  TitleLabel.swift
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
//
import SwiftUI

struct TitleLabel: View {
    var title: String
    var body: some View {
        HStack{
            Text(title.localized)
                .foregroundStyle(.main)
                .font(addFont(fontType: .Medium, size: 18))
            Spacer()
        }
    }
}

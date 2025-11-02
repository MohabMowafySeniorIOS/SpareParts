//
//  SmallButtonComponent.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 15/07/2025.
//
import SwiftUI

struct SmallButtonComponent: View {
    var action: () -> Void
    var title: String
    var body: some View {
        Button {
            action()
        } label: {
            Text(title.localized)
                .foregroundStyle(.cWhite)
                .font(addFont(fontType: .Light, size: 15))
                .frame(width: 170, height: 35)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.main)
                )
        }
    }
}

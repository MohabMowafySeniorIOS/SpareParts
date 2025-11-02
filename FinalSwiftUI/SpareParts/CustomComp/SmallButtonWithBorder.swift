//
//  SmallButtonWithBorder.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 15/07/2025.
//

import SwiftUI

struct SmallButtonWithBorder: View {
    var action: () -> Void
    var title: String
    var body: some View {
        Button {
            action()
        } label: {
            Text(title.localized)
                .foregroundStyle(.main)
                .font(addFont(fontType: .Light, size: 15))
                .frame(width: 150, height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(style: StrokeStyle())
                        .fill(.main)
                )
                .padding(1)
        }
    }
}
#Preview(body: {
    SmallButtonWithBorder(action: {}, title: "any")
})

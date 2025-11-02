//
//  MyOrdersCardView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 18/07/2025.
//

import SwiftUI
struct MyOrdersCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("1225")
                .font(addFont(fontType: .Regular, size: 14))
                .foregroundStyle(.cBlack)
                .padding(.horizontal, 2)
                .padding(.vertical, 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.cBlack, lineWidth: 1)
                )
                .padding(.top,15)
            
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("localhost")
                        .font(addFont(fontType: .Regular, size: 13))
                        .foregroundStyle(.cBlack)
                    
                    Text("onprogress")
                        .font(addFont(fontType: .Regular, size: 13))
                        .foregroundStyle(.cBlack)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 15) {
                    HStack(spacing: 5) {
                        Text("count")
                            .font(addFont(fontType: .Regular, size: 13))
                            .foregroundStyle(.cBlack)
                        Text("5")
                            .font(addFont(fontType: .Regular, size: 13))
                            .foregroundStyle(.cBlack)
                    }
                    
                    HStack(spacing: 5) {
                        Text("15/2/2025")
                            .font(addFont(fontType: .Regular, size: 13))
                            .foregroundStyle(.cBlack)
                        Text("3:30م")
                            .font(addFont(fontType: .Regular, size: 13))
                            .foregroundStyle(.cBlack)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            Spacer()
        }
        .frame(width: 350, height: 130)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(style: StrokeStyle())
            .fill(.cBlack))
        .padding(1)
    }
}

//
//  OffersCardView.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 19/07/2025.
//

import SwiftUI

struct OffersCardView: View {
    var canMessage: Bool
    let part: OffersCardModel
    let buttonTitle: String
    let onShowPictures: () -> Void
    let onMessage: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {

            HStack {
                Text(part.name)
                    .font(addFont(fontType: .bold, size: 15))
                    .foregroundStyle(Color.CBlack)
                    .lineLimit(1)

                Spacer()

                Image(systemName: "person.crop.circle.fill")
                    .foregroundStyle(Color.MainColor)
                    .font(.system(size: 20))
            }

            Text(part.price)
                .font(addFont(fontType: .bold, size: 16))
                .foregroundStyle(Color.MainColor)

            HStack(spacing: 10) {
                if canMessage {
                    Button(action: onMessage) {
                        Image(systemName: "ellipsis.message.fill")
                            .foregroundStyle(Color.MainColor)
                            .font(.system(size: 16))
                            .frame(width: 40, height: 40)
                            .background(
                                Circle().fill(Color.MainColor.opacity(0.12))
                            )
                    }
                }

                Button(action: onShowPictures) {
                    Text(buttonTitle.localized)
                        .font(addFont(fontType: .Medium, size: 14))
                        .foregroundStyle(Color.CWhite)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.MainColor)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(16)
        .frame(width: 240)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
    }
}

struct OfferInfoRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(icon)
                .resizable()
                .foregroundStyle(Color.SecondaryColor)
                .frame(width: 24, height: 24)

            Text(text)
                .foregroundStyle(Color.CGray1)
                .font(addFont(fontType: .Medium, size: 16))

            Spacer()
        }
    }
}

#Preview {
    OffersCardView(
        canMessage: true, part: .init(
            name: "Someone",
            country: "Saudi Arabia",
            city: "Riyadh",
            price: "5000 SAR"
        ), buttonTitle: "show images",
        onShowPictures: {
            print("Show pictures tapped")
        }, onMessage: {
            print("Message tapped")
        }
    )
}

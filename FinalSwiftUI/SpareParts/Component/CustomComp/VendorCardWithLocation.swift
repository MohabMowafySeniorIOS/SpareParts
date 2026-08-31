//
//  VendorCard.swift
//  MyAuctions
//
//  Created by Mohab on 10/07/2025.
//

import Foundation
import SwiftUI

struct VendorCardModel {
    let name: String
    let image: String
    let country: String
    let city: String
    let location: String
    let rating: Double
    let isfavorite: Bool
}

struct VendorCardWithLocation: View {

    let vendor: Trader
    @State var startSize: CGFloat = 12
    @State var paddingValue: CGFloat = 1
    var orderNow: ()->Void
    var openLocation: ()->Void
    var pressFavourite: ()->Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                RemoteImageView(imageUrl: vendor.logo?.path ?? "")
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                Text(vendor.tradeName ?? "")
                    .font(addFont(fontType: .bold, size: 16))
                    .foregroundStyle(Color.CBlack)

                Spacer()

                Image(systemName: vendor.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(vendor.isFavorite ? Color.CRed : Color.CGray2)
                    .font(.system(size: 20))
                    .onTapGesture {
                        pressFavourite()
                    }
            }

            HStack(spacing: 6) {
                CustomStarRatingView(rating: vendor.ratingAvg ?? 0.0, startSize: $startSize, paddingValue: $paddingValue)
                Text(String(format: "%.1f", vendor.ratingAvg ?? 0.0))
                    .font(addFont(fontType: .bold, size: 14))
                    .foregroundStyle(Color.CBlack)
                Text("(\(Int(vendor.ratingCount ?? 0)))")
                    .font(addFont(fontType: .Regular, size: 13))
                    .foregroundStyle(Color.CGray2)
            }

            HStack(spacing: 4) {
                Image(systemName: "mappin.circle.fill")
                    .foregroundStyle(Color.CGray2)
                    .font(.system(size: 13))
                Text("\(vendor.country?.name ?? "") • \(vendor.city?.name ?? "")")
                    .font(addFont(fontType: .Regular, size: 13))
                    .foregroundStyle(Color.CGray2)
                    .lineLimit(1)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Capsule().fill(Color.CGray4))

            HStack(spacing: 6) {
                Image.darkLocation
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                Text("distance_between_vendor_customer".localized)
                    .font(addFont(fontType: .bold, size: 14))
                    .foregroundStyle(Color.MainColor)
            }
            .onTapGesture {
                openLocation()
            }

            SimpleSpareButton(buttonTitle: "order_now".localized, action: {
                orderNow()
            }, widthValue: .infinity, heightValue: 46)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}

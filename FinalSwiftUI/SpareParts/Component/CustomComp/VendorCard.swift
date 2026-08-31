//
//  VendorCard.swift
//  MyAuctions
//
//  Created by Mohab on 10/07/2025.
//

import Foundation
import SwiftUI

struct VendorCard: View {
    
    @State var startSize: CGFloat = 25
    @State var paddingValue: CGFloat = 10
    
    var vendorsModel: Trader?
    var orderNow: ()->Void
    var favouriteAction: ()->Void
    
    var body: some View {
        VStack(alignment: .center,spacing: 15){
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text(vendorsModel?.tradeName ?? "")
                        .font(.custom(AppFont.bold.rawValue, size: 16))
                    Spacer()
                    Text(vendorsModel?.country?.name ?? "")
                        .font(.custom(AppFont.Regular.rawValue, size: 16))
                    Spacer()
                    Text(vendorsModel?.city?.name ?? "")
                        .font(.custom(AppFont.Regular.rawValue, size: 16))
                }
                Spacer()
                RemoteImageView(imageUrl: vendorsModel?.logo?.path ?? "")
                    .scaledToFill()
                    .frame(width: 70, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.SecondaryColor, lineWidth: 1)
                    )
            }
            HStack{
                Image(systemName: "heart.fill")
                    .foregroundStyle( vendorsModel?.isFavorite == true ? Color.CRed : Color.CGray2)
                    .font(.system(size: 30))
                    .onTapGesture {
                        favouriteAction()
                    }

                CustomStarRatingView(rating: vendorsModel?.ratingAvg ?? 0.0, startSize: $startSize, paddingValue: $paddingValue)
            }
            Button {
                orderNow()
            } label: {
                Text("order_now".localized)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color.MainColor)
                    .cornerRadius(22)
            }
            .buttonStyle(.plain)

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
        .padding(1)
        .padding(.trailing,7)
    }
}
#Preview(body: {
//    VendorCard(verndors: 3)
})

protocol VendorDisplayable {
    var id: Int? { get }
    var name: String? { get }
    var logo: Logo? { get }
    var cityName: String? { get }
    var city: City? { get }
    var rating: Double? { get }
}


struct VendorGridCard: View {
    var orderNow: ()->Void
    var vendorsModel: Trader?
    var favouriteAction: ()->Void
    @State private var startSize: CGFloat = 12
    @State private var paddingValue: CGFloat = 1
    @State private var navToOrderNow: Bool = false


    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // MARK: - Name + Logo + Favourite
            HStack {
                RemoteImageView(imageUrl: vendorsModel?.logo?.path ?? "")
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                Text(vendorsModel?.tradeName ?? "")
                    .font(addFont(fontType: .bold, size: 16))
                    .foregroundStyle(Color.CBlack)

                Spacer()

                Image(systemName: vendorsModel?.isFavorite == true ? "heart.fill" : "heart")
                    .foregroundStyle( vendorsModel?.isFavorite == true ? Color.CRed : Color.CGray2)
                    .font(.system(size: 20))
                    .onTapGesture {
                        favouriteAction()
                    }
            }

            // MARK: - Rating
            HStack(spacing: 6) {
                CustomStarRatingView(
                    rating: vendorsModel?.ratingAvg ?? 0.0,
                    startSize: $startSize,
                    paddingValue: $paddingValue
                )
                Text(String(format: "%.1f", vendorsModel?.ratingAvg ?? 0.0))
                    .font(addFont(fontType: .bold, size: 14))
                    .foregroundStyle(Color.CBlack)
                Text("(\(Int(vendorsModel?.ratingCount ?? 0)))")
                    .font(addFont(fontType: .Regular, size: 13))
                    .foregroundStyle(Color.CGray2)
            }

            // MARK: - Location pill
            if vendorsModel?.city != nil {
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundStyle(Color.CGray2)
                        .font(.system(size: 13))
                    Text("\(vendorsModel?.country?.name ?? "") • \(vendorsModel?.city?.name ?? "")")
                        .font(addFont(fontType: .Regular, size: 13))
                        .foregroundStyle(Color.CGray2)
                        .lineLimit(1)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Capsule().fill(Color.CGray4))
            }

            // MARK: - Button
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

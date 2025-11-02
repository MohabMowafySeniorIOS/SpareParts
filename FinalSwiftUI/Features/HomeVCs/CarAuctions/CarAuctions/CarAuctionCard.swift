//
//  CarAuctionCard.swift
//  MyAuctions
//
//  Created by مهاب موافي on 7/2/25.
//

import Foundation
import SwiftUI
struct CarAuctionCard: View {

    var Item : AuctionItemData?
    var index : Int = 0

    @State var isFavourite : Bool = false
    @State var naviToDetails : Bool = false
    
    var body: some View {
        NavigationStack{
            NavigationLink("", destination: CarAuctionDetailsView(), isActive: $naviToDetails)
            VStack(alignment: .leading, spacing: 10) {

                ZStack(alignment: .topLeading) {
                    FavouriteImageButton(isFavourite: $isFavourite)
                        .onTapGesture {
                            isFavourite.toggle()
                        }
                    ZStack {
                        RemoteImageView(imageUrl: Item?.thumbnail ?? "")
                            .presentationCornerRadius(10)
                            .frame(width: 200,height: 150)
                            .cornerRadius(10)
                            .scaledToFit()
                            .clipped()
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        naviToDetails = true
                    }
                }.frame(maxWidth: .infinity)

                HStack {
                    HStack {
                        Text("city".localized)
                            .foregroundStyle(.cBlack)

                        Text(Item?.city ?? "")
                            .foregroundStyle(.cGray1)
                    }
                    Spacer()
                    HStack {
                        Text("address".localized)
                            .foregroundStyle(.cBlack)

                        Text("Item.a")
                            .foregroundStyle(.cGray1)
                    }
                    Spacer()
                }

                HStack {
                    Text("publish_date".localized)
                        .foregroundStyle(.cBlack)

                    Text(Item?.publicationDate ?? "")
                    Spacer()
                }

                HStack {
                    Text("start_day_and_date".localized)
                        .foregroundStyle(.cBlack)

                    Text(Item?.startDayDate ?? "")
                    Spacer()
                }

                HStack {
                    Text("end_day_and_date".localized)
                        .foregroundStyle(.cBlack)

                    Text(Item?.endDayDate ?? "")
                    Spacer()
                }

                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("car_state".localized)
                                .foregroundStyle(.cBlack)

                            Text(Item?.carStatusText ?? "")
                                .foregroundStyle(.cGray1)
                        }
                        HStack {
                            Text("model".localized)
                                .foregroundStyle(.cBlack)
                            Text("\(Item?.year ?? 0)")
                                .foregroundStyle(.cGray1)
                        }
                        HStack {
                            Text("manufacture_date".localized)
                                .foregroundStyle(.cBlack)
                            Text(Item?.publicationDate ?? "")
                                .foregroundStyle(.cGray1)
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("category".localized)
                                .foregroundStyle(.cBlack)
                            Text(Item?.category ?? "")
                                .foregroundStyle(.cGray1)
                        }
                        HStack {
                            Text("model".localized)
                                .foregroundStyle(.cBlack)
                            Text(Item?.brand ?? "")
                                .foregroundStyle(.cGray1)
                        }
                        HStack {
                            Text("transmission".localized)
                                .foregroundStyle(.cBlack)
                            Text(Item?.transmission ?? "")
                                .foregroundStyle(.cGray1)
                        }
                    }

                }

                Text("price".localized + " : 6841 " + "sr".localized)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .background((index % 2 == 0)
                        ? Color.cGray4 : Color.clear)

        }
        }
}

#Preview(body: {
    CarAuctionCard()
})

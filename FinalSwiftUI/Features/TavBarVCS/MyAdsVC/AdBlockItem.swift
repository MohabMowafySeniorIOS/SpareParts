//
//  AdBlockItem.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/29/25.
//

import Foundation
import SwiftUI
struct AdBlockItem: View {

    var item : Listing?
//    @State var cardNumber: String
//    @State var cardName: String
//    @State var id: String
//    @State var time: String
//    @State var adType: String
//    @State var price: String
//    @State var fullPrice: String
//    @State var adState: String
    @State var isNavi: Bool = false
    @State var bgColor: Color

    var body: some View {
        ZStack {
            NavigationLink("", isActive: $isNavi) {
                CarAuctionDetailsView()
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("\(item?.id ?? 0)")
                    .foregroundStyle(.cBlack)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 7)
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(style: StrokeStyle())
                            .fill(.cBlack)
                    )
                    .frame(maxWidth: .infinity, alignment: .center)

                Text(item?.title ?? "")
                    .foregroundStyle(.cBlack)
                    .frame(maxWidth: .infinity, alignment: .center)

                HStack {
                    VStack(alignment: .leading,spacing: 10) {
                        //first bar
                        HStack {
                            Text("id".localized)
                                .fontWeight(.semibold)
                                .padding(.trailing)

                            Text("\(item?.id ?? 0)")
                        }
                        //second bar
                        HStack {
                            Image(systemName: "clock")
                                .foregroundStyle(.main)
                                .padding(.trailing)
                                .font(.system(size: 20))

                            Text(item?.publicationDate ?? "")
                        }
                        //third bar
                        HStack {
                            Text("ad_type".localized)
                                .padding(.trailing)
                                .fontWeight(.semibold)

                            Text(item?.type ?? "")
                        }
                    }

                    Spacer()
                    VStack(alignment: .leading,spacing: 10) {
                        HStack {
                            Text("price".localized)
                                .padding(.trailing)
                                .fontWeight(.semibold)

                            Text(item?.price ?? "")
                        }

                        HStack {
                            Text("full_price".localized)
                                .padding(.trailing)
                                .fontWeight(.semibold)

                            Text(item?.price ?? "")
                        }
                        HStack {
                            Text("ad_state".localized.capitalized)
                                .padding(.trailing)
                                .fontWeight(.semibold)

                            Text(item?.status ?? "")
                        }
                    }
                }.padding(.horizontal)

            }
            .padding(.vertical)
            .onTapGesture {
                isNavi.toggle()
            }
            

        }.background(bgColor)
    }
}

//
//  VendorCard.swift
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
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
    
    @Binding var rating: Double
    @State var startSize: CGFloat = 15
    @State var paddingValue: CGFloat = 2
    @State var isFavourite: Bool = false
    
    @State private var navToOrderNow: Bool = false
    
    var body: some View {
            VStack{
                VStack(alignment: .leading,spacing: 10){
                    HStack(alignment: .top){
                        VStack(alignment: .leading,spacing: 10){
                            Text("vendor_name")
                                .font(addFont(fontType: .Medium, size: 15))
                            Text("saudia")
                                .font(addFont(fontType: .Light, size: 15))
                            Text("jaddah")
                                .font(addFont(fontType: .Light, size: 15))
                        }
                        Spacer()
                        Image(.portraitWhiteManIsolated)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.cBlack, lineWidth: 1)
                            )
                    }
                    .frame(width: 150)
                    .padding(.horizontal, 20)
                    HStack{
                        Text("space_between_client_vendor")
                            .foregroundStyle(.main)
                            .multilineTextAlignment(.leading)
                            .font(addFont(fontType: .Medium, size: 15))
                        Image.darkLocation
                    }
                    .frame(width: 150)
                    .padding(.horizontal)
                    
                    HStack{
                        Image(systemName: "heart.fill")
                            .foregroundStyle(isFavourite ? .cRed : .CGray2)
                            .font(.system(size: 15))
                            .onTapGesture {
                                isFavourite.toggle()
                            }
                        CustomStarRatingView(rating: $rating, startSize: $startSize, paddingValue: $paddingValue)
                    }
                    .padding(.leading, 18)
                    
                }
                SimpleSpareButton(buttonTitle: "order_now", action: {
                    navToOrderNow = true
                }, widthValue: 150, heightValue: 32)
                .padding(.top, 5)
                .navigationDestination(isPresented: $navToOrderNow) {
                    VendorDetailsView()
                }
            }
            .frame(width:180 ,height: 250)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 1))
                    .fill(.cBlack)
            )
            .padding(1)

    }
}
#Preview(body: {
    VendorCardWithLocation(rating: .constant(3))
})

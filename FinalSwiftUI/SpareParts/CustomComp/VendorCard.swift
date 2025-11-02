//
//  VendorCard.swift
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
//

import Foundation
import SwiftUI

struct VendorCard: View {
    
    @Binding var rating: Double
    @State var startSize: CGFloat = 25
    @State var paddingValue: CGFloat = 10
    @State var isFavourite: Bool = false
    
    @State private var navToOrderNow: Bool = false
    
    var body: some View {
        VStack(alignment: .center,spacing: 15){
            HStack(alignment: .top,spacing:60){
                VStack(alignment: .leading){
                    Text("vendor_name")
                    Spacer()
                    Text("saudia")
                    Spacer()
                    Text("jaddah")
                }
                Image(.portraitWhiteManIsolated)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.main, lineWidth: 2)
                    )
            }
            HStack{
                Image(systemName: "heart.fill")
                    .foregroundStyle(isFavourite ? .cRed : .CGray2)
                    .font(.system(size: 25))
                    .onTapGesture {
                        isFavourite.toggle()
                    }
                CustomStarRatingView(rating: $rating, startSize: $startSize, paddingValue: $paddingValue)
            }
            Button {
                navToOrderNow = true
            } label: {
                Text("order_now".localized)
                    .foregroundStyle(.cWhite)
                    .frame(width: 200,height: 50)
                    .background(
                        .main
                    )
                    .cornerRadius(30)
            }
            .navigationDestination(isPresented: $navToOrderNow) {
                VendorDetailsView()
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .fill(.main)
        )
        .padding(1)
        .padding(.trailing,7)
    }
}
#Preview(body: {
    VendorCard(rating: .constant(3))
})

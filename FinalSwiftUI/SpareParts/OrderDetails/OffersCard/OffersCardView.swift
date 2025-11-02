//
//  OffersCardView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 19/07/2025.
//

import SwiftUI

struct OffersCardView: View {
    let part: OffersCardModel

    var body: some View {
        HStack{
            VStack(alignment:.leading,spacing:20){
                    HStack (spacing:55){
                        Image(systemName: "person")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))
                        Text(part.name)
                    }
                    HStack(spacing:55) {
                        Image(systemName: "house")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))
                        Text(part.country)
                    }
                    HStack (spacing:55){
                        Image(systemName: "house")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))
                        Text("\(part.city)")
                    }
                HStack(spacing:55){
                        Image(systemName: "banknote")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))
                        Text(part.price)
                    }
                    HStack {
                        Button {

                        } label: {
                            Text("show_pictures".localized)
                                .foregroundStyle(.cWhite)
                                .frame(width: 150, height: 35)
                                .background(
                                    Color.main
                                        .cornerRadius(20)
                                )
                        }
                        
                        Image(systemName: "message.fill")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))
                        
                    }
                    .padding(.horizontal,10)
            }
            Spacer()
        }
        .padding(.leading,10)
        .frame(width: 230, height: 240)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle())
                .fill(.main)

        ).padding(1)

    }
}

#Preview {
    OffersCardView(part: .init(name: "someone", country: "saudia", city: "bied", price: "5000"))
}

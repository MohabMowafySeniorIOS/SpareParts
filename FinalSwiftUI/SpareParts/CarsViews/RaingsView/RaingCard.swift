//
//  RaingCard.swift
//  MyAuctions
//
//  Created by Moaaz on 07/07/2025.
//

import SwiftUI



struct RatingSingleCardView: View {
    


    
    let card: RatingCard
    let index: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            //cardnum
            HStack {
                Spacer()
                Text("\(index + 1)")
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 24, height: 24)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.main, lineWidth: 1)
                            .background(Color.clear.cornerRadius(8))
                    )
                    .foregroundColor(Color.main)
                Spacer()
            }

            HStack(spacing: 15) {
                Text("الوقت والتاريخ")
                    .font(addFont(fontType: .bold, size: 15))
                    .foregroundColor(.main)

                Text(card.date)
                    .font(.system(size: 15))
                    .foregroundColor(.main)

                Text(card.time)
                    .font(.system(size: 15))
                    .foregroundColor(.main)
            }

            HStack(spacing: 15) {

                Text("اسم المستخدم")
                    .font(addFont(fontType: .bold, size: 15))
                    .foregroundColor(.main)
                Text(card.userName)
                    .font(addFont(fontType: .Medium, size: 15))
                    .foregroundColor(.main.opacity(0.8))
            }

            HStack(spacing: 8) {
                Text(card.ratingText)
                    .font(addFont(fontType: .bold, size: 15))
                    .foregroundColor(.main)
                
                Text(String(format: "%.1f", card.rating))
                    .font(addFont(fontType: .Medium, size: 15))
                    .foregroundColor(.main)
                
                HStack(spacing: 2) {
                    ForEach(0..<5) { star in
                        Image(
                            systemName: star < Int(card.rating)
                                ? "star.fill"
                                : (star < Int(ceil(card.rating))
                                    ? "star.lefthalf.fill" : "star")
                        )
                        .foregroundColor(.yellow)
                    }
                }
                
                
                Spacer()
            }
            Text("نص التقييم")
                .font(addFont(fontType: .bold, size: 15))
                .foregroundColor(.main)
            Text(card.reviewText)
                .font(addFont(fontType: .Medium, size: 15))
                .foregroundColor(.main.opacity(0.8))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.main, lineWidth: 1)
                .background(Color.clear.cornerRadius(12))
        )
        .padding(.horizontal, 8)
        .padding(.top, 16)
    
        .padding(.horizontal,10)
    }
}


//#Preview {
//    RatingSingleCardView(card: RatingCard, index: <#Int#>)
//}

//
//  RaingCard.swift
//  MyAuctions
//
//  Created by Mohab on 07/07/2025.
//

import SwiftUI



struct RatingSingleCardView: View {
    
    let card: ratingData
    @State var startSize: CGFloat = 15
    @State var paddingValue: CGFloat = 2
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            


            HStack(spacing: 15) {

                Text("user_name".localized)
                    .font(addFont(fontType: .bold, size: 15))
                    .foregroundColor(Color.SecondaryColor)
                Text(card.user?.name ?? "")
                    .font(addFont(fontType: .bold, size: 15))
                    .foregroundColor(Color.SecondaryColor.opacity(0.8))
            }

            HStack(spacing: 8) {
                Text("\(card.rating ?? 0.0)".toEnglishDigits())
                    .font(addFont(fontType: .bold, size: 15))
                    .foregroundColor(Color.SecondaryColor)
                CustomStarRatingView(rating: card.rating ?? 0.0, startSize: $startSize, paddingValue: $paddingValue)
//                Text(String(format: "%.1f", "\(card.rating ?? 0.0)"))
//                    .font(addFont(fontType: .bold, size: 15))
//                    .foregroundColor(Color.SecondaryColor)
                
//                HStack(spacing: 2) {
//                    ForEach(0..<5) { star in
//                        Image(
//                            systemName: star < Int(card.rating ?? 0.0)
//                                ? "star.fill"
//                            : (star < Int(ceil(card.rating ?? 0.0))
//                                    ? "star.lefthalf.fill" : "star")
//                        )
//                        .foregroundColor(.yellow)
//                    }
//                }
                
                
                Spacer()
            }
            Text("Rating Text".localized)
                .font(addFont(fontType: .bold, size: 15))
                .foregroundColor(Color.SecondaryColor)
            Text(card.comment ?? "")
                .font(addFont(fontType: .bold, size: 15))
                .foregroundColor(Color.SecondaryColor.opacity(0.8))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)
        .padding(.horizontal, 8)
        .padding(.top, 16)
    
        .padding(.horizontal,10)
    }
}


//#Preview {
//    RatingSingleCardView(card: RatingCard, index: <#Int#>)
//}

//
//  OfferDetailsView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 19/07/2025.
//

import SwiftUI

struct OfferDetailsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack{
                NormalAppBar(title: "offer_details") {
                    dismiss()
                }
            }
            ScrollView{
                LazyVStack(spacing:15){
                    
                    HStack{
                        Text("parts_menu")
                            .foregroundStyle(.main)
                            .font(addFont(fontType: .Medium, size: 18))
                        Spacer()
                    }.padding(.vertical,5)
                    
                    PieceDetailsCard()
                    
                    TotalCostCardView()
                    
                    SimpleSpareButton(buttonTitle: "accept_offer", action: {
                        
                    }, widthValue: 300, heightValue: 50)
                    .padding(.top)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    OfferDetailsView()
}



//
//  AdditionalAddressDescribtionView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 19/07/2025.
//

import SwiftUI

struct AdditionalAddressDescribtionView: View {
    var body: some View {
        VStack{
            VStack(spacing:20){
                HStack{
                    TitleLabel(title: "address_describtion")
                    Spacer()
                }
                
                Text("address_describtion_textoquwehfqbwuhecbiuhewbictuhwebirtcuhweirutbciewurthbciuewbrt")
                    .foregroundStyle(.cBlack)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .background(.cWhite)
                    .cornerRadius(10)
                
                HStack{
                    SimpleSpareButton(buttonTitle: "automatic_gps", action: {
                        
                    }, widthValue: 150, heightValue: 35)
                    Spacer()
                    SmallButtonWithBorder(action: {
                        
                    }, title: "add")
                }
                .padding(.horizontal)
                
            }.padding()
        }
        .background(.cGray3)
    }
}

#Preview {
    AdditionalAddressDescribtionView()
}

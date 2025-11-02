//
//  VisaPaymentMethodCard.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 20/07/2025.
//

import SwiftUI

struct VisaPaymentMethodCard: View {
    var body: some View {
        VStack{
            ZStack{
                Text("title".localized)
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                HStack{
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(.main)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            HStack(spacing:40){
                Text("balance_amount".localized)
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                Spacer()
                Text("1000rs".localized)
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
            }
            .padding()
            
            HStack(spacing:40){
                Text("refrence_number".localized)
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                Spacer()
                Text("1552".localized)
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
            }
            .padding(.horizontal)
            
            SimpleSpareButton(buttonTitle: "download_receipt", action: {
                
            }, widthValue: 200, heightValue: 40)
        }
        .frame(height: 250)
        .background(.cWhite)
        .cornerRadius(10)

    }
}

#Preview {
    VisaPaymentMethodCard()
}

//
//  ChargeWalletView.swift
//  MyAuctions
//
//  Created by Moaaz on 17/06/2025.
//

import SwiftUI

enum PaymentMethod{
    case visa , masterCard
}

struct ChargeWalletView: View {
    
    
    @EnvironmentObject var navi: AppState
    @Environment(\.dismiss) var dismiss
    @State var fieldText: String = ""
    @State var paymentMethod: PaymentMethod = .visa
    
    
    var body: some View {
        NavigationStack{
            
            AppHeaderView(Title:"charge_wallet", action: {dismiss()})
            
            VStack(spacing: 15){
                HStack{
                    Text("enter_charge_value".localized)
                        .font(addFont(fontType: .Medium, size: 20))
                    Spacer()
                }
                
                TextField("100 " + "R.S".localized, text: $fieldText)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(style: StrokeStyle())
                            .fill(.cGray3)
                    )
                    .padding(.bottom)
                
                HStack{
                    Text("choose_payment_method".localized)
                        .font(addFont(fontType: .bold, size: 20))
                    Spacer()
                }
                
                ChargeWalletBar(
                    paymentMethod: .visa,
                    action: {paymentMethod = .visa},
                    icon: Image(.KSA),
                    title: "visa",
                    boxIcon: paymentMethod == .visa ? Image.checkedIcon :
                        Image.unCheckedIcon
                )
                
                ChargeWalletBar(
                    paymentMethod: .masterCard,
                    action: {paymentMethod = .masterCard},
                    icon: Image(.USA),
                    title: "master_card", boxIcon: paymentMethod == .masterCard ? Image.checkedIcon :
                        Image.unCheckedIcon
                )
                
                Spacer()
                
                HStack{
                    ContentButtonView(title: "confirm".localized) {
                        navi.mainTabSelection = 3
                        navi.goToHome()
                    }
                    Spacer(minLength: 16)
                    CustomeButtonWithBorderColor(title: "cancel".localized) {
                        navi.mainTabSelection = 4
                        navi.goToHome()
                    }
                }
                    
                }
                .padding()
                .frame(height: .infinity)
                .ignoresSafeArea()
                
                Spacer()
            }
            .navigationBarBackButtonHidden()
        }
    }


#Preview {
    ChargeWalletView()
}

struct ChargeWalletBar: View {
    
    var paymentMethod: PaymentMethod
    var action: () -> Void
    var icon: Image
    var title: String
    var boxIcon: Image
    
    var body: some View {
        HStack{
            HStack{
                icon
                
                Text(title.localized)
                    .font(addFont(fontType: .Regular, size: 20))
            }
            Spacer()
            
            boxIcon
                .renderingMode(.template)
                .foregroundStyle(.main)
            
        }
        .padding(10)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.cGray1.opacity(0.3))
        )
        .onTapGesture {
            action()
        }
    }
}

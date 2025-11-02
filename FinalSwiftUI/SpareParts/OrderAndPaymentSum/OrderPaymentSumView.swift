//
//  OrderPaymentSumView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 20/07/2025.
//

import SwiftUI

struct OrderPaymentSumView: View {
    
    @State var fieldText: String = ""
    @State var isTerms: Bool = false
    @State var isTermsColor: Bool = false
    @State var isVisa: Bool = true
    @State var isMasterCard: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                NormalAppBar(title: "Order_payment_sum") {
                    
                }
                ScrollView {
                    VStack(spacing:20){
                        
                        HStack(spacing:70){
                            TitleLabel(title: "vendor_name")
                            Text("some name")
                            Spacer()
                        }
                        
                        HStack(spacing:70){
                            TitleLabel(title: "country")
                            Text("some name")
                            Spacer()
                        }
                        
                        HStack(spacing:70){
                            TitleLabel(title: "city")
                            Text("some name")
                            Spacer()
                        }
                        
                        HStack(spacing:70){
                            TitleLabel(title: "address")
                            Text("some name")
                            Spacer()
                        }
                        
                        HStack(spacing:70){
                            TitleLabel(title: "delivery_type")
                            Text("some name")
                            Spacer()
                        }
                        
                        TitleLabel(title: "available_parts_menu")
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHStack(spacing: 10){
                                ForEach(0..<5){_ in
                                    AvailablePartsCard()

                                }
                            }
                        }
                        
                        TitleLabel(title: "use_wallet_balance")
                        
                        HStack{
                            Image(systemName: "wallet.pass.fill")
                                .foregroundStyle(.main)
                                .font(.system(size: 30))
                            
                            Text("wallet_balance".localized)
                                .foregroundStyle(.main)
                            
                                TextField("cash".localized, text: $fieldText)
                                    .keyboardType(.numberPad)
                                    .padding(13)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(style: StrokeStyle())
                                            .fill(.main)
                                    )
                                    .padding(.leading, 7)
                            Spacer()
                            }
                        .padding(.trailing)
                        .padding(.trailing)
                        
                        TitleLabel(title: "enter_required_balance")
                        
                        TextField("cash".localized, text: $fieldText)
                            .keyboardType(.numberPad)
                            .padding(13)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(style: StrokeStyle())
                                    .fill(.main)
                            )
                            .padding(.trailing)
                            .padding(.trailing)
                            .padding(.trailing)
                        
                        TitleLabel(title: "cost_details")
                        
                        HStack(spacing:70){
                            TitleLabel(title: "part_total_cost")
                            Text("100 rs")
                            Spacer()
                        }
                        
                        HStack(spacing:70){
                            TitleLabel(title: "charge_price")
                            Text("1000 rs")
                            Spacer()
                        }
                        
                        HStack(spacing:70){
                            TitleLabel(title: "total_cost")
                            Text("1000 rs")
                            Spacer()
                        }
                        
                        HStack(spacing:70){
                            TitleLabel(title: "wallet_balance_used")
                            Text("1000 rs")
                            Spacer()
                        }
                        
                        HStack(spacing:70){
                            TitleLabel(title: "total_payment")
                            Text("1000 rs")
                            Spacer()
                        }
                        TitleLabel(title: "choose_payment_method")
                        
                        SelectorBarWithIcon(iconName: "wallet.pass.fill", title: "visa", isSelected: $isVisa)
                            .onTapGesture {
                                isVisa = true
                                isMasterCard = false
                            }
                        
                        SelectorBarWithIcon(iconName: "wallet.pass.fill", title: "master_card", isSelected: $isMasterCard)
                            .onTapGesture {
                                isVisa = false
                                isMasterCard = true
                            }
                        
                        TermsView(isSelected: $isTerms, textColorChange: $isTermsColor)
                            .onTapGesture {
                                isTerms.toggle()
                            }
                        
                        SimpleSpareButton(buttonTitle: "confirm_payment", action: {
                            
                        }, widthValue: 320, heightValue: 50)
                        
                    }
                    .padding(.horizontal)
                    
                    
                }
            }
        }
    }
}

#Preview {
    OrderPaymentSumView()
}

struct AvailablePartsCard: View {
    var body: some View {
        VStack(spacing:10){
            HStack(spacing:70){
                TitleLabel(title: "part_name")
                Text("some name")
            }
            
            HStack(spacing:70){
                TitleLabel(title: "part_number")
                Text("12")
            }
            
            HStack(spacing:70){
                TitleLabel(title: "part_type")
                Text("some name")
            }
            
            HStack(spacing:70){
                TitleLabel(title: "number")
                Text("3")
            }
            
            HStack(spacing:70){
                TitleLabel(title: "price")
                Text("100 rs")
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle()).fill(.main))
        .padding(1)
    }
}

struct SelectorBarWithIcon: View {
    var iconName: String
    var title: String
    @Binding var isSelected: Bool
    var body: some View {
        HStack(){
            Circle()
                .fill(isSelected ? .main : .clear)
                .frame(width: 15,height: 15)
                .overlay {
                    ZStack{
                        Image(systemName: "checkmark")
                            .font(.system(size: 10))
                            .foregroundStyle(.cWhite)
                        Circle()
                            .stroke(style: StrokeStyle())
                            .fill(isSelected ? .main : .cGray1)
                        
                    }
                }
            
            Spacer()
            HStack{
                Text(title.localized)
                    .foregroundStyle(.main)
                
                Image(systemName: iconName)
                    .foregroundStyle(.main)
            }
        }
        .padding(10)
        .background(.cGray3)
        .cornerRadius(10)
    }
}

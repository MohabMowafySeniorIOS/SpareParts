//
//  TransActionCardView.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/28/25.
//

import Foundation
import SwiftUI
struct WalletBlockItem: View {
    
    var item : TransactionItem?
//    var productNumber: String
//    var referenceNumber: String
//    var operationType: String
//    var chargeMethod: String
//    var moneyAmount: String
//    var time: String
    var bgColor: Color
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 10) {
            Text("\(item?.id ?? 0)")
                .foregroundStyle(.cBlack)
                .padding(.vertical, 2)
                .padding(.horizontal, 7)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(style: StrokeStyle())
                        .fill(.cBlack)
                )
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)
            
            VStack(alignment:.leading){
                HStack(spacing:16){
                    
                    VStack(alignment:.leading,spacing:10){
                        WalletCardItem(title: "reference_number", value: item?.referenceID ?? "")
                        Spacer()
                        WalletCardItem(title: "operation_type", value: item?.type ?? "")
                        
                        Spacer()
                    }
                    
                    VStack(alignment:.leading,spacing:10){
                        WalletCardItem(title: "money_amount", value: item?.amount ?? "")
                        Spacer()
                        HStack {
                            Image(systemName: "clock")
                                .foregroundStyle(.main)
                            
                            Text(item?.createdAt ?? "")
                            
                        }
                        Spacer()
                    }
                }
                Spacer()
                
                WalletCardItem(title: "charge_method", value: item?.metadata?.paymentMethod ?? "")
                
            }
            .padding(10)
            
        }
        .background(bgColor)
    }
    
    struct WalletCardItem: View {
        var title: String
        var value: String
        var body: some View {
            HStack {
                Text("\(title)".localized)
                Text(value)
            }
        }
    }
}

struct WalletUsageBlockItem: View {
    
    var productNumber: String
    var referenceNumber: String
    var productName: String
    var moneyAmount: String
    var time: String
    var bgColor: Color
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 10) {
            Text(productNumber)
                .foregroundStyle(.cBlack)
                .padding(.vertical, 2)
                .padding(.horizontal, 7)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(style: StrokeStyle())
                        .fill(.cBlack)
                )
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack(alignment:.leading){
                HStack(spacing:16){
                    
                    VStack(alignment:.leading,spacing:10){
                        WalletCardItem(title: "reference_number", value: referenceNumber)
                        Spacer()
                        WalletCardItem(title: "money_amount", value: moneyAmount)
                        
                        Spacer()
                    }
                    
                    VStack(alignment:.leading,spacing:10){
                        WalletCardItem(title: "product_name", value: productName)
                        Spacer()
                        HStack {
                            Image(systemName: "clock")
                                .foregroundStyle(.main)
                            
                            Text(time)
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(10)
            
        }
        .padding()
        .background(bgColor)
    }
    
    struct WalletCardItem: View {
        var title: String
        var value: String
        var body: some View {
            HStack {
                
                Text("\(title)".localized)
                Text(value)
                
            }
        }
    }
}

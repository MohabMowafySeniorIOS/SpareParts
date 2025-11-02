//
//  TotalCostCardView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 19/07/2025.
//
import SwiftUI

struct TotalCostCardView: View {
    var body: some View {
        HStack(){
            VStack(alignment: .leading,spacing: 10){
                
                Text("total_price")
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                
                Text("charge_price")
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                
                Text("total_cost")
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                
            }
            Spacer()
            VStack(alignment: .leading,spacing: 10){
                
                Text("1000 rs")
                    .foregroundStyle(.cGray1)
                
                Text("1000 rs")
                    .foregroundStyle(.cGray1)
                
                Text("1000 rs")
                    .foregroundStyle(.cGray1)
                
            }
            .padding(.trailing)
            
        }
        .padding()
        .frame(height:120)
        .background(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle())
            .fill(.main))
    }
}

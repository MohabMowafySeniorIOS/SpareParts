//
//  PieceDetailsCard.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 19/07/2025.
//
import SwiftUI

struct PieceDetailsCard: View {
    var body: some View {
        HStack(){
            VStack(alignment: .leading,spacing: 10){
                
                Text("piece_name")
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                
                Text("piece_number")
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                
                Text("iece_type")
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                
                Text("count")
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                
                Text("price")
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                
            }
            Spacer()
            VStack(alignment: .leading,spacing: 10){
                
                Text("baack_half")
                    .foregroundStyle(.cGray1)
                
                Text("12")
                    .foregroundStyle(.cGray1)
                
                Text("new_original")
                    .foregroundStyle(.cGray1)
                
                Text("3")
                    .foregroundStyle(.cGray1)
                
                Text("100 rs")
                    .foregroundStyle(.cGray1)
                
            }
            .padding(.trailing)
            
        }
        .padding()
        .frame(height:200)
        .background(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle())
            .fill(.main))
    }
}

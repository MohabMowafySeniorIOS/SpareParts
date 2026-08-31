//
//  AddCityCard 2.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 16/07/2025.
//

import SwiftUI

struct AddVendorCard: View {
    let Model: Trader
    var deleteAction:()->Void
    var body: some View {
        VStack(spacing:10){
            VStack(alignment:.leading){
                HStack(spacing:50){
                    VStack(alignment:.leading,spacing:10){
                        Image(systemName: "person")
                            .foregroundStyle(Color.MainColor)
                        
                        Image(systemName: "house")
                            .foregroundStyle(Color.MainColor)
                        
                        
                        Image(systemName: "house")
                            .foregroundStyle(Color.MainColor)
                    }
                    VStack(alignment:.leading,spacing:10){
                        Text(Model.tradeName ?? "")
                            .foregroundStyle(Color.MainColor)
                        
                        Text(Model.country?.name ?? "")
                            .foregroundStyle(Color.MainColor)
                        
                        Text(Model.city?.name ?? "")
                            .foregroundStyle(Color.MainColor)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
            
            SimpleSpareButton(buttonTitle: "Delete".localized, action: {
                deleteAction()
            }, widthValue: 150, heightValue: 30)
            
        }
        .padding(10)
        .frame(width: 250)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle())
                .fill(Color.MainColor)
        }
        .padding(1)
    }
    
   
}

struct DetailsVendorCard: View {
    let Model: Target

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            detailRow(icon: "person", text: Model.tradeName ?? "")
            detailRow(icon: "house", text: Model.country?.name ?? "")
            detailRow(icon: "house", text: Model.city?.name ?? "")
        }
        .padding(16)
        .frame(width: 250)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
    }

    private func detailRow(icon: String, text: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(Color.MainColor)
            Spacer()
            Text(text)
                .font(addFont(fontType: .bold, size: 14))
                .foregroundStyle(Color.MainColor)
        }
    }
}

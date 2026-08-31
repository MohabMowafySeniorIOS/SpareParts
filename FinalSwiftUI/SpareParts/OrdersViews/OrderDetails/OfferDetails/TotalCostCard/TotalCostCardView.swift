//
//  TotalCostCardView.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 19/07/2025.
//
import SwiftUI

struct TotalCostCardView: View {
    var Model: Offer
    var body: some View {
        HStack(){
            VStack(alignment: .leading,spacing: 10){
               
                Text("Price (incl. tax)".localized)
                    .foregroundStyle(Color.MainColor)
                    .font(addFont(fontType: .Medium, size: 18))
                
                Text("Charge Price".localized)
                    .foregroundStyle(Color.MainColor)
                    .font(addFont(fontType: .Medium, size: 18))
                
                Text("Total Cost".localized)
                    .foregroundStyle(Color.MainColor)
                    .font(addFont(fontType: .Medium, size: 18))
                
            }
            Spacer()
            VStack(alignment: .leading,spacing: 10){
                
                Text((firstNonZeroDecimal((Model.taxAmount ?? 0.0) + (Model.subtotal ?? 0.0))))
                    .foregroundStyle(Color.CGray1)
                
                Text(firstNonZeroDecimal(Model.shippingCost ?? 0.0))
                    .foregroundStyle(Color.CGray1)
                
                Text(firstNonZeroDecimal(Model.totalAmount ?? 0.0))
                    .foregroundStyle(Color.CGray1)
                
            }
            .padding(.trailing)
            
        }
        .padding()
        .frame(height:120)
        .background(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle())
            .fill(Color.MainColor))
    }
    
    func firstNonZeroDecimal(_ value: Double) -> String {
        let integerPart = Int(value)
        let decimalString = String(format: "%.15f", value)
            .split(separator: ".")[1]

        if let digit = decimalString.first(where: { $0 != "0" }) {
            return "\(integerPart).\(digit)"
        } else {
            return "\(integerPart)"
        }
    }
}

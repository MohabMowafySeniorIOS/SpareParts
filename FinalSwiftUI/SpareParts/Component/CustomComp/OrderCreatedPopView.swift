//
//  OrderCreatedPopView.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 18/07/2025.
//

import SwiftUI

struct OrderCreatedPopView: View {
    var body: some View {
        VStack(spacing:20){
            Image("carImage")
                .frame(height: 200)
            
            Text("your order has been created".localized)
            
            HStack(spacing:20){
                SimpleSpareButton(buttonTitle: "orders_list", action: {
                    
                }, widthValue: 150, heightValue: 30)
                
                SmallButtonWithBorder(action: {
                    
                }, title: "main")
            }
        }
        .padding(20)
        .background(Color.CWhite)
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.10), radius: 12, x: 0, y: 4)
    }
}

#Preview {
    OrderCreatedPopView()
}

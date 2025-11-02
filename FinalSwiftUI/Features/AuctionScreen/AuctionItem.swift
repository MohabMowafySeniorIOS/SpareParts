//
//  AuctionItem.swift
//  FinalSwiftUI
//
//  Created by Mohab on 19/05/2025.
//

import SwiftUI

struct AuctionItem: View {
    @State var Label : String
    @State var Value : String
    var body: some View {
        HStack(spacing:20) {
            Text(Value)
                .font(addFont(fontType: .Regular, size: 14))
                .foregroundColor(Color.hex("#A7A6A6"))
            
            Text(Label)
                .font(addFont(fontType: .bold, size: 14))
                .foregroundColor(Color.hex("#333333"))
            
           
        }
    }
}

#Preview {
    AuctionItem(Label: "Label", Value: "Value")
}

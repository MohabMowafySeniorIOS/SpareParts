//
//  BindingItemCellView.swift
//  FinalSwiftUI
//
//  Created by Mohab on 19/05/2025.
//

import SwiftUI

struct BindingItemCellView: View {
    @State var label : String
    @State var value : String
    
    var body: some View {
        HStack(spacing:26) {
            Text(label)
                .font(addFont(fontType: .bold, size: 14))
                .foregroundColor(Color.hex("#333333"))
           
            Text(value)
                .font(addFont(fontType: .Regular, size: 14))
                .foregroundColor(Color.hex("#333333"))
        }
    }
}

#Preview {
    BindingItemCellView(label: "Date", value: "12-5-2025")
}

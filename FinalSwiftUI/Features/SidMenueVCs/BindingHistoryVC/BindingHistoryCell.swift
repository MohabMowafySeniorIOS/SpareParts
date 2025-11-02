//
//  BindingHistoryCell.swift
//  FinalSwiftUI
//
//  Created by Mohab on 18/05/2025.
//

import SwiftUI

import SwiftUI

struct BindingHistoryCell: View {
    var body: some View {
        VStack(spacing: 12) {
            // Top row with trophy icon and number
            HStack {
                Spacer()
                HStack(spacing: 8) {
                    Image("Trophy")
                        .foregroundColor(.teal)
                    Text("1")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                }
                Spacer()
            }

            // Details
            
            HStack {
                BindingItemCellView(label: "Date", value: "6:5")
                Spacer()
                BindingItemCellView(label: "Time", value: "6:5")
            }
            
            HStack {
                BindingItemCellView(label: "Name", value: "6:5")
                Spacer()
               
            }
            
            HStack {
                BindingItemCellView(label: "Price", value: "6:5")
                Spacer()
               
            }
           
          
           

         
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        
        
    }
}

struct InfoCardView_Previews: PreviewProvider {
    static var previews: some View {
        BindingHistoryCell()
    }
}

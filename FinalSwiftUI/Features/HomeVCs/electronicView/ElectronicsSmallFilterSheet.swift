//
//  ElectronicsSmallFilterSheet.swift
//  MyAuctions
//
//  Created by Moaaz on 19/06/2025.
//

import SwiftUI

struct ElectronicsSmallFilterSheet: View {
    var body: some View {
        VStack(alignment:.leading, spacing: 10){
            HStack{
                Text("new_first")
                    .foregroundStyle(.cBlack)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                Spacer()
            }
            
            HStack {
                Text("old_first")
                    .foregroundStyle(.cBlack)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                Spacer()
            }
            
            HStack {
                Text("lowest_price_first")
                    .foregroundStyle(.cBlack)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                Spacer()
            }
            
            HStack {
                Text("highest_price_first")
                    .foregroundStyle(.cBlack)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                
                Spacer()
            }
        }
        .padding(10)
        .padding(.trailing)
        .frame(maxWidth: 300)
        .frame(maxHeight: 200)
        .background(.cGray5)
        .cornerRadius(15)
        .background()
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.cBlack.opacity(0.3))
        
    }
}

#Preview {
    ElectronicsSmallFilterSheet()
}

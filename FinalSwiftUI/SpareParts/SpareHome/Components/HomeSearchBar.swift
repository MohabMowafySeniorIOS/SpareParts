//
//  HomeSearchBar.swift
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
//
import SwiftUI

struct HomeSearchBar: View {
    
    @Binding var searchFieldText: String
    var body: some View {
        HStack{
            Button {
                
            } label: {
                Text("search".localized)
                    .padding()
                    .padding(.horizontal)
                    .foregroundStyle(.cWhite)
                    .background(.main)
            }
            HStack{
                TextField("vendor_name".localized, text: $searchFieldText)
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .foregroundStyle(.main)
            }
            .padding(.horizontal)
            
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle())
                .fill(.main)
                .padding(1)
        )
        .cornerRadius(10)
        .padding(.vertical)
    }
}

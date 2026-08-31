
//
//  HomeSearchBar.swift
//  MyAuctions
//
//  Created by Mohab on 10/07/2025.
//
import SwiftUI
var searchText = ""
struct HomeSearchBar: View {
    
    @Binding var searchFieldText: String
    var searchAction: ()->Void
    var body: some View {
        HStack{
            Button {
                searchAction()
            } label: {
                Text("search".localized)
                    .font(.custom(AppFont.bold.rawValue, size: 16))
                    .padding()
                    .padding(.horizontal)
                    .foregroundStyle(Color.CWhite)
                    .background(Color.MainColor)
            }
            HStack{
                TextField("vendor_name".localized, text: $searchFieldText)
                    .onChange(of: searchFieldText) { newValue in
                        searchText = newValue
                    }
                    .font(.custom(AppFont.bold.rawValue, size: 16))
                    .foregroundStyle(Color.MainColor)
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.MainColor)
            }
            .padding(.horizontal)
            
        }
        .onAppear {
            searchFieldText = searchText
        }
        .background(Color.CWhite)
        .cornerRadius(28)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
        .padding(.vertical)
    }
}

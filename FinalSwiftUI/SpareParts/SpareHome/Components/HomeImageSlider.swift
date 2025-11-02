//
//  HomeImageSlider.swift
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
//
import SwiftUI

struct HomeImageSlider: View {
    
    @Binding var tabSelection: Int
    @Binding var images: [Image]
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ForEach(0..<images.count, id: \.self) { index in
                images[index]
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(height:180)
                    .cornerRadius(15)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height:180)
        
        HStack(spacing: 8){
            ForEach(0..<images.count, id: \.self) { index in
                Circle()
                    .fill(index == tabSelection ? .main : .clear)
                    .frame(width: 12, height: 12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle())
                        .fill(Color.cBlack.opacity(0.7))
                    )
            }
        }
    }
}

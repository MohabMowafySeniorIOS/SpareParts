//
//  HorizontalImageScroller.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 15/07/2025.
//

import SwiftUI


struct HorizontalImageScroller: View {
    let images: [Image]
    @Binding var currentImage: Image?
    // Local names or URLs
    
    var body: some View {
        VStack{
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(0..<images.count, id: \.self) { index in
                        let image = images[index]
                        image
                            .resizable()
                            .onTapGesture {
                                currentImage = image
                            }
                            .mainImageFormation(width: 100, height: 100)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

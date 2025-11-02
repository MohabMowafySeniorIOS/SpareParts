//
//  ImagePickerAndSlider.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 17/07/2025.
//
import SwiftUI

struct ImagePickerAndSlider: View {
    @Binding var pickedImages: [UIImage]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(0..<4, id: \.self) { index in
                    if index < pickedImages.count {
                        Image(uiImage: pickedImages[index])
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(8)
                            .onTapGesture {
                                pickedImages.remove(at: index)
                            }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.cGray1)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}

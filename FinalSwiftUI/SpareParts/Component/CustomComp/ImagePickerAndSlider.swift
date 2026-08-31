//
//  ImagePickerAndSlider.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 17/07/2025.
//
import SwiftUI

struct ImagePickerAndSlider: View {
    @Binding var pickedImages: [AttachMentModel?]
    @Binding var is_validation_label: Bool
    var Validation_label: String = "Please Choose Images".localized
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                HStack(spacing: 15) {
                    ForEach(0..<4, id: \.self) { index in
                        if index < pickedImages.count {
                            if index < pickedImages.count {
                                ZStack(alignment: .top) {
                                    RemoteImageView(imageUrl: pickedImages[index]?.path ?? "")
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(14)
                                        
                                    
                                        HStack {
                                          Image("close")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .onTapGesture {
                                                pickedImages.remove(at: index)
                                            }
                                            Spacer()
                                        }
                                  
                                    
                                }.frame(width: 100, height: 100)

                               
                            }
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color.CGray1)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
                if !is_validation_label {
                    HStack{
                        Text(Validation_label.localized)
                            .font(addFont(fontType: .bold, size: 12))
                            .foregroundStyle(Color.CRed)
                        
                        Spacer()
                    }
                }
            }
            
        }
    }
}

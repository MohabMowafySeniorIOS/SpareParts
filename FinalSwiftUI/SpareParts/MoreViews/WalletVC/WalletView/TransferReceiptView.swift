//
//  TransferReceiptView.swift
//  SpareParts
//
//  Created by Mohab on 04/03/2026.
//

import Foundation
import SwiftUI

struct ReceiptPopupView: View {
    
    let imageURL: String
    @Binding var showPopup: Bool
    
    var body: some View {
        
        ZStack {
            
            // الخلفية الشفافة
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    showPopup = false
                }
            
            VStack(spacing: 20) {
                
                HStack {
                    
                    Button {
                        showPopup = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    Text("عرض صورة التحويل")
                        .font(.headline)
                    
                    Spacer()
                }
                
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxHeight: 350)
                .cornerRadius(12)
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.15), radius: 14, x: 0, y: 6)
            .padding(.horizontal, 30)
        }
        .transition(.opacity)
        .animation(.easeInOut, value: showPopup)
    }
}

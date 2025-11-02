//
//  AddedPieceImagesPopView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 17/07/2025.
//

import SwiftUI

struct AddedPieceImagesPopView: View {
    let onActivate: () -> Void
    let onCancel: () -> Void
    var body: some View {
        VStack{
            ZStack{
                Text("added images".localized)
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .Medium, size: 18))
                HStack{
                    Button(action: onCancel) {
                        Image(systemName: "xmark")
                            .font(.system(size: 25))
                            .foregroundColor(.main)
                    }
                        
                    Spacer()
                }
            }
            .padding(.top,5)
            .padding(.horizontal)
            
            HStack{
                Image(.car)
                    .frame(width: 180, height: 130)
                
                Image(.car)
                    .frame(width: 180, height: 130)
            }
            
            HStack{
                Image(.car)
                    .frame(width: 180, height: 130)
                
                Image(.car)
                    .frame(width: 180, height: 130)
            }

        }
        .frame(width: 380,height: 330)
        .background(.cWhite)
        .cornerRadius(10)
    }
}

#Preview {
    AddedPieceImagesPopView(onActivate: {}, onCancel: {})
}

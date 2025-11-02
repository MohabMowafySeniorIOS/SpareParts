//
//  SelectorBarCustomView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 16/07/2025.
//

import SwiftUI

struct SelectorBarCustomView: View {
    var title: String
    var isSelected: Bool

    var body: some View {
        HStack() {
            Circle()
                .fill(isSelected ? .main : .clear)
                .frame(width: 15,height: 15)
                .overlay {
                    ZStack{
                        Image(systemName: "checkmark")
                            .font(.system(size: 10))
                            .foregroundStyle(.cWhite)
                        Circle()
                            .stroke(style: StrokeStyle())
                            .fill(isSelected ? .main : .cGray1)

                    }
                }
            
            Text(title.localized)
            Spacer()
        }
    }
}
//#Preview {
//    SelectorBarCustomView(title: "test", isSelected: .constant(true))
//}

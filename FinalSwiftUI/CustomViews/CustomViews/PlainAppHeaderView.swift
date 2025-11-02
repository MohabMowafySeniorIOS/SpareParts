//
//  PlainAppHeaderView.swift
//  MyAuctions
//
//  Created by Moaaz on 08/07/2025.
//
import SwiftUI


struct PlainAppHeaderView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title.localized)
                .foregroundStyle(.cWhite)
                .font(.system(size: 20))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.main)
    }
}

//
//  AddCityCard 2.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 16/07/2025.
//

import SwiftUI

struct AddVendorCard: View {
    var body: some View {
        VStack(spacing:10){
            VStack(alignment:.leading){
                HStack(spacing:50){
                    VStack(alignment:.leading,spacing:10){
                        Image(systemName: "person")
                            .foregroundStyle(.main)
                        
                        Image(systemName: "house")
                            .foregroundStyle(.main)
                        
                        Image(systemName: "house")
                            .foregroundStyle(.main)
                        
                        Image(systemName: "house")
                            .foregroundStyle(.main)
                    }
                    VStack(alignment:.leading,spacing:10){
                        Text("some name")
                            .foregroundStyle(.main)
                        
                        Text("house")
                            .foregroundStyle(.main)
                        
                        Text("some region")
                            .foregroundStyle(.main)
                        
                        Text("house")
                            .foregroundStyle(.main)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
            
            SimpleSpareButton(buttonTitle: "delete", action: {
                
            }, widthValue: 150, heightValue: 30)
            
        }
        .padding(10)
        .frame(width: 250)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle())
                .fill(.main)
        }
        .padding(1)
    }
}

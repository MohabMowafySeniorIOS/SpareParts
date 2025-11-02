//
//  MyCarsView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 20/07/2025.
//

import SwiftUI

struct MyCarsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                NormalAppBar(title: "my_cars") {
                    dismiss()
                }
                ScrollView(.vertical, showsIndicators: false){
                    LazyVStack(spacing:20) {
                        SimpleSpareButton(buttonTitle: "add_card", action: {
                            
                        }, widthValue: 300, heightValue: 50)
                        .padding(.top)
                        
                        TitleLabel(title: "added_cars_menu")
                        
                        ForEach(0..<5) { _ in
                            AddCarCard()
                        }

                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    MyCarsView()
}

struct AddCarCard: View {
    var body: some View {
        VStack{
            HStack(spacing:30){
                VStack(alignment:.leading,spacing:10){
                    HStack(spacing:90){
                        Text("category")
                            .foregroundStyle(.main)
                    }
                    
                    HStack(spacing:90){
                        Text("brand")
                            .foregroundStyle(.main)
                    }
                    
                    HStack(spacing:90){
                        Text("model")
                            .foregroundStyle(.main)
                    }
                    
                    HStack(spacing:90){
                        Text("manufacture_year")
                            .foregroundStyle(.main)
                    }
                    
                    HStack(spacing:90){
                        Text("chest_number")
                            .foregroundStyle(.main)
                    }
                }
                
                VStack(alignment:.leading,spacing:10){
                    HStack(spacing:90){
                        Text("cope")
                            .foregroundStyle(.main)
                    }
                    
                    HStack(spacing:90){
                        Text("nissan")
                            .foregroundStyle(.main)
                    }
                    
                    HStack(spacing:90){
                        Text("nissan sunny")
                            .foregroundStyle(.main)
                    }
                    
                    HStack(spacing:90){
                        Text("2012")
                            .foregroundStyle(.main)
                    }
                    
                    HStack(spacing:90){
                        Text("17834bv528asdf")
                            .foregroundStyle(.main)
                    }
                }
                Spacer()
            }
            HStack{
                SimpleSpareButton(buttonTitle: "edit", action: {
                    
                }, widthValue: 160, heightValue: 30)
                
                SmallButtonWithBorder(action: {
                    
                }, title: "delete")
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle()).fill(.main))
        .padding(1)
    }
}

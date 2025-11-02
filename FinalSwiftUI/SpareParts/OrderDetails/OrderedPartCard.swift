//
//  OrderedPartCard.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 19/07/2025.
//
import SwiftUI

struct OrderedPartCard: View {
    let part: Part
    let id: Int

    var body: some View {
        VStack{
            Text("\(id)")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                .frame(width: 25,height: 25)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(style: StrokeStyle())
                        .fill(.main)
                        .padding(1)
                )
            VStack (spacing: 10){
                // ID at the top center
                
                HStack {
                    Text("اسم القطعة")
                        .foregroundStyle(.main)
                    Spacer()
                    Text(part.name)
                    Spacer()
                }
                HStack {
                    Text("رقم القطعة")
                        .foregroundStyle(.main)
                    Spacer()
                    Text(part.number)
                    Spacer()
                }
                HStack {
                    Text("عدد القطع")
                        .foregroundStyle(.main)
                    Spacer()
                    Text("\(part.count)")
                    Spacer()
                }
                HStack {
                    Text("نوع القطعة")
                        .foregroundStyle(.main)
                    Spacer()
                    Text(part.type)
                    Spacer()
                }
                HStack{
                    VStack (spacing: 10){
                        Button {
                            
                        } label: {
                            Text("show_pictures".localized)
                                .foregroundStyle(.cWhite)
                                .frame(width: 150, height: 30)
                                .background(
                                    Color.main
                                        .cornerRadius(20)
                                )
                        }
                        
                    }
                }
            }
        }
        .frame(width: 200,height: 200)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle())
                .fill(.main)
            
        ).padding(1)

    }
}

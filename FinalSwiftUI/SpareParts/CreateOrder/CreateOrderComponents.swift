//
//  CreateOrderComponents.swift
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
//

import Foundation
import SwiftUI

struct NormalAppBar: View {
    var title: String
    @State var action: () -> Void
    var body: some View {
        ZStack{
            Text(title.localized)
                .foregroundStyle(.cWhite)
                .font(addFont(fontType: .Medium, size: 18))
            HStack{
                Image.RightArrow
                    .resizable()
                    .frame(width: 26, height: 12)
                    .padding(.leading, 12)
                    .scaleEffect(x:appLanguage == "ar" ? -1 : 1, y: 1)
                    
//                    .font(.title)
//                    .foregroundColor(Color.white)
                Spacer()
            }
            .onTapGesture {
                action()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.main)
    }
}

struct DoubleHTitleLabel: View {
    
     var head: String
     var tail: String
    
    var body: some View {
        ZStack{
            Text(tail.localized)
                .foregroundStyle(.cGray1)
                .font(addFont(fontType: .Medium, size: 17))
            HStack{
                Text(head.localized)
                    .foregroundStyle(.main)
                    .font(addFont(fontType: .SemiBold, size: 18))
                Spacer()
            }
        }
    }
}

struct AddedCarSelectionBar: View {
    var title: String
    @Binding var isClicked: Bool
    var body: some View {
        HStack{
            HStack{
                Text(title.localized)
                    .foregroundStyle(.main)
                Spacer()
                Image(systemName: "chevron.down")
                    .font(.system(size: 20))
                    .rotationEffect(Angle(degrees: isClicked ? 180 : 0))
                    .onTapGesture {
                        isClicked.toggle()
                    }
            }
            .padding(.horizontal)
            .frame(width: 300,height: 40)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(style: StrokeStyle())
                    .fill(.main)
            )
            .padding(.trailing)
            Spacer()

            Image(systemName: "plus")
                .foregroundStyle(.cBlue.opacity(0.7))
                .font(.system(size: 30))
                .onTapGesture {
                    //add navigation
                }
            
        }
    }
}

struct PartCard: View {
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
                    Spacer()
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
                        
                        Button {
                            
                        } label: {
                            Text("delete_piece".localized)
                                .foregroundStyle(.main)
                                .frame(width: 150, height: 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(style: StrokeStyle())
                                        .fill(.main)
                                )
                        }
                    }
                    Spacer()
                }
            }
        }
        .frame(width: 200,height: 220)
        .padding(10)
        .padding(.vertical,5)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle())
                .fill(.main)
            
        ).padding(1)

    }
}

struct PartsList: View {
    let parts: [Part]
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack{
                Text("added_parts_menu".localized)
                Spacer()
                Image(systemName: "plus")
                    .foregroundStyle(.cBlue.opacity(0.7))
                    .font(.system(size: 30))
                    .onTapGesture {
                        //add navigation
                    }
            }
            .padding(.trailing)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(parts.indices, id: \.self) { idx in
                        PartCard(part: parts[idx], id: idx + 1)
                    }
                }
            }
        }
    }
}

struct DeliveryTypeSelector: View {
    @Binding var selectedType: DeliveryType
    var fieldType: DeliveryType
    var title: String

    var body: some View {
        HStack() {
            Circle()
                .fill(selectedType == fieldType ? .main : .clear)
                .frame(width: 15,height: 15)
                .overlay {
                    ZStack{
                        Image(systemName: "checkmark")
                            .font(.system(size: 10))
                            .foregroundStyle(.cWhite)
                        Circle()
                            .stroke(style: StrokeStyle())
                            .fill(selectedType == fieldType ? .main : .cGray1)

                    }
                }
            
            Text(title.localized)
            Spacer()
        }
    }
}
struct CreateOrderSelectionBar: View {

    var isChecked: Bool
    var title: String
    var imageName: String
    var body: some View {
        HStack {
            if !isChecked {
                RoundedRectangle(cornerRadius: 2)
                    .stroke(style: StrokeStyle())
                    .fill(.cGray1)
                    .frame(width: 20, height: 20)
                    .padding(.trailing)
            } else {
                RoundedRectangle(cornerRadius: 2)
                    .fill(.main)
                    .frame(width: 20, height: 20)
                    .overlay {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.cWhite)
                    }
                    .padding(.trailing)
            }

            Text(title.localized)
                .foregroundStyle(isChecked ? .main : .cGray1)
                .padding(.trailing)
            
            Image(systemName: imageName)
                .font(.system(size: 20))

            Spacer()
        }

    }
}

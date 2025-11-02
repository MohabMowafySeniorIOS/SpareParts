//
//  OrderDetailsView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 19/07/2025.
//

import SwiftUI

struct OrderDetailsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                NormalAppBar(title: "order_details") {
                    dismiss()
                }
            }
            ScrollView {
                VStack (spacing:10){
                    HStack(){
                        VStack(alignment: .leading,spacing: 10){
                            HStack{
                                Image(systemName: "number")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.main)
                                
                                Text("piece_name")
                                    .foregroundStyle(.cGray1)
                                    .font(addFont(fontType: .Medium, size: 18))
                            }
                            
                            HStack{
                                Image(systemName: "house")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.main)
                                
                                Text("piece_name")
                                    .foregroundStyle(.cGray1)
                                    .font(addFont(fontType: .Medium, size: 18))
                            }
                            
                            HStack{
                                Image(systemName: "house")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.main)
                                
                                Text("piece_name")
                                    .foregroundStyle(.cGray1)
                                    .font(addFont(fontType: .Medium, size: 18))
                            }
                            
                            HStack{
                                Image(systemName: "person")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.main)
                                
                                Text("piece_name")
                                    .foregroundStyle(.cGray1)
                                    .font(addFont(fontType: .Medium, size: 18))
                            }
                            
                            HStack{
                                Image(systemName: "hourglass")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.main)
                                
                                Text("piece_name")
                                    .foregroundStyle(.cGray1)
                                    .font(addFont(fontType: .Medium, size: 18))
                            }
                        }
                        Spacer()
                        VStack(alignment: .leading,spacing: 10){
                            
                            HStack{
                                Image(systemName: "box.truck")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.main)
                                
                                Text("piece_name")
                                    .foregroundStyle(.cGray1)
                                    .font(addFont(fontType: .Medium, size: 18))
                            }
                            
                            HStack{
                                Image(systemName: "house")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.main)
                                
                                Text("piece_name")
                                    .foregroundStyle(.cGray1)
                                    .font(addFont(fontType: .Medium, size: 18))
                            }
                            HStack{
                                Image(systemName: "calendar")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.main)
                                
                                Text("piece_name")
                                    .foregroundStyle(.cGray1)
                                    .font(addFont(fontType: .Medium, size: 18))
                            }
                            HStack{
                                Image(systemName: "car")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.main)
                                
                                Text("piece_name")
                                    .foregroundStyle(.cGray1)
                                    .font(addFont(fontType: .Medium, size: 18))
                            }
                            HStack{
                                Image(systemName: "box.truck")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.main)
                                
                                Text("piece_name")
                                    .foregroundStyle(.cGray1)
                                    .font(addFont(fontType: .Medium, size: 18))
                            }
                            
                        }
                        .padding(.trailing)
                        
                    }.padding(10)
                    
                    TitleLabel(title: "address_details")
                        .padding(.horizontal)
                    
                    HStack{
                        Image(systemName: "map")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))
                        Spacer()
                        Text("somewhere near to somewhere  ")
                            .frame(width:200)
                            .padding(.trailing,10)
                    }
                    .padding(.horizontal,10)
                    
                    TitleLabel(title: "address_extra_details")
                        .padding(.horizontal)
                    Text("somewhere near to somewhere in some bigger where ")
                        .padding(.horizontal)
                    
                    TitleLabel(title: "car_details")
                        .padding(.horizontal)
                    
                    VStack{
                        HStack{
                            VStack(spacing:10){
                                HStack{
                                    Image(systemName: "car")
                                        .foregroundStyle(.main)
                                        .font(.system(size: 25))
                                    Text("car_number")
                                        .foregroundStyle(.cGray1)
                                        .font(addFont(fontType: .Medium, size: 18))
                                }
                                
                                HStack{
                                    Image(systemName: "car")
                                        .foregroundStyle(.main)
                                        .font(.system(size: 25))
                                    Text("car_number")
                                        .foregroundStyle(.cGray1)
                                        .font(addFont(fontType: .Medium, size: 18))
                                }
                                
                            }
                            Spacer()
                            VStack(spacing:10){
                                HStack{
                                    Image(systemName: "car")
                                        .foregroundStyle(.main)
                                        .font(.system(size: 25))
                                    Text("car_number")
                                        .foregroundStyle(.cGray1)
                                        .font(addFont(fontType: .Medium, size: 18))
                                }
                                
                                HStack{
                                    Image(systemName: "car")
                                        .foregroundStyle(.main)
                                        .font(.system(size: 25))
                                    Text("car_number")
                                        .foregroundStyle(.cGray1)
                                        .font(addFont(fontType: .Medium, size: 18))
                                }
                                
                            }.padding(.trailing)
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        Image(systemName: "car")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))
                        Text("car_number")
                            .foregroundStyle(.cGray1)
                            .font(addFont(fontType: .Medium, size: 18))
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    TitleLabel(title: "ordered_parts_menu")
                        .padding()
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        LazyHStack(spacing:10){
                            ForEach(0..<5) { _ in
                                OrderedPartCard(part: .init(name: "uwbd", number: "qwef", count: "wer", type: "wer"), id: 78)
                            }
                        }
                        .padding(.leading)
                    }
                    
                    TitleLabel(title: "offer_menu")
                        .padding()
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        LazyHStack(spacing:10){
                            ForEach(0..<5) { _ in
                                OffersCardView(part: .init(name: "someone", country: "saudia", city: "ryiadh", price: "1000 rs"))
                            }
                        }
                        .padding(.leading)
                    }
                    
                    TitleLabel(title: "payment_details")
                        .padding()
                    
                    VStack{
                        HStack(){
                            VStack(alignment: .leading,spacing: 10){
                                
                                HStack(){
                                    Image(systemName: "number")
                                        .foregroundStyle(.main)
                                        .font(.system(size: 25))
                                    
                                    Text("1000 rs")
                                        .foregroundStyle(.cGray1)
                                }
                                
                                HStack(){
                                    Image(systemName: "banknote")
                                        .foregroundStyle(.main)
                                        .font(.system(size: 25))
                                    
                                    Text("1000 rs")
                                        .foregroundStyle(.cGray1)
                                }
                                
                            }
                            Spacer(minLength: 50)
                            VStack(alignment: .leading,spacing: 10){
                                
                                HStack(){
                                    Image(systemName: "wallet")
                                        .foregroundStyle(.main)
                                        .font(.system(size: 25))
                                    
                                    Text("1000 rs")
                                        .foregroundStyle(.cGray1)
                                }
                                
                                HStack(){
                                    Image(systemName: "calendar")
                                        .foregroundStyle(.main)
                                        .font(.system(size: 25))
                                    
                                    Text("1000 rs")
                                        .foregroundStyle(.cGray1)
                                }
                                
                            }
                            .padding(.trailing)
                            
                            
                        }
                        Image(systemName: "arrow.down.to.line")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))
                    }
                    .padding()
                    .frame(height:120)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle())
                        .fill(.main))
                    .padding(.horizontal)

                    SimpleSpareButton(buttonTitle: "cancel_order", action: {
                        
                    }, widthValue: 300, heightValue: 50)
                    .padding(.top)
                    
                }
            }
        }
    }
}

#Preview {
    OrderDetailsView()
}



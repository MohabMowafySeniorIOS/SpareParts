//
//  VendorsMenuFilterCardView.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 15/07/2025.
//

import SwiftUI
enum SortedType {
    case newest
    case nearest
    case rating
}

struct VendorsMenuFilterCardView: View {
    @Binding var filterObject: FilterObject
    @Binding var isVendorMenu: Bool
    @State var orderBy: SortedType?
   
   
    var body: some View {
                
                VStack(spacing:20){
                    Spacer()
                    Text("sort_list".localized)
                 
                    newestView
                    locationView
                    ratingView
                    buttonSection
                }
                .onAppear {
                    orderBy = filterObject.orderBy
                   
                }
                .frame(maxHeight: .infinity)
                .background(
                    Color.backGroundColor
                )

    }
    
    private var newestView: some View {
        HStack{
            Text("oldest_to_newest".localized)
                .foregroundStyle(orderBy == .newest ? Color.CWhite : .gray)
                .padding(5)
                .padding(.horizontal,5)
                .background(orderBy == .newest ? Color.MainColor : .white)
                .cornerRadius(14)
                .onTapGesture {
                    orderBy = .newest
                }
            Spacer()
//            Text("newest_to_oldest".localized)
//                .foregroundStyle(isNew == false ? .white : .gray)
//                .padding(5)
//                .padding(.horizontal,5)
//                .background(isNew == false ? Color.MainColor : .white)
//                .cornerRadius(14)
//                .onTapGesture {
//                    isNew = false
//                }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var locationView: some View {
        HStack{
            Text("farthest_to_nearest".localized)
                .foregroundStyle(orderBy == .nearest ? .white : .gray)
                .padding(5)
                .padding(.horizontal,5)
                .background(orderBy == .nearest ? Color.MainColor : .white)
                .cornerRadius(14)
                .onTapGesture {
                    orderBy = .nearest
                }
            Spacer()
//            Text("nearest_to_farthest".localized)
//                .foregroundStyle(isFar == false ? .white : .gray)
//                .padding(5)
//                .padding(.horizontal,5)
//                .background(isFar == false ? Color.MainColor : .white)
//                .cornerRadius(14)
//                .onTapGesture {
//                    isFar = false
//                }
//            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var ratingView: some View {
        HStack{
            Text("highest_to_lowest_price".localized)
                .foregroundStyle(orderBy == .rating ? .white : .gray)
                .padding(5)
                .padding(.horizontal,5)
                .background(orderBy == .rating ? Color.MainColor : .white)
                .cornerRadius(14)
                .onTapGesture {
                    orderBy = .rating
                }
            Spacer()
//            Text("nearest_to_farthest".localized)
//                .foregroundStyle(isFar == false ? .white : .gray)
//                .padding(5)
//                .padding(.horizontal,5)
//                .background(isFar == false ? Color.MainColor : .white)
//                .cornerRadius(14)
//                .onTapGesture {
//                    isFar = false
//                }
//
            Spacer()
        }
        .padding(.horizontal)
        
       
        }
   
    
    private var buttonSection: some View {
        HStack{
            SimpleSpareButton(buttonTitle: "confirm".localized, action: {
                filterObject.orderBy = orderBy
               
                isVendorMenu = false
            }, widthValue: 160, heightValue: 30)
            
            SmallButtonWithBorder(action: {
                filterObject.orderBy = nil
                isVendorMenu = false
            }, title: "Reset".localized)
        }
        .padding(.horizontal)
        
    }
}


//
//  VendorsMenuFilterCardView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 15/07/2025.
//

import SwiftUI

struct VendorsMenuFilterCardView: View {
    
    @State var isNew: Bool = true
    @State var isFar: Bool = true
    @State var isBest: Bool = true
    
    var body: some View {
                
                VStack(spacing:20){
                    Spacer()
                    Text("filter_menu_by".localized)
                    HStack{
                        Text("older_to_newer".localized)
                            .foregroundStyle(isNew ? .cWhite : .cWhite)
                            .padding(5)
                            .padding(.horizontal,5)
                            .background(isNew ? .main : .cGray1)
                            .cornerRadius(5)
                            .onTapGesture {
                                isNew = true
                            }
                        Spacer()
                        Text("older_to_newer".localized)
                            .foregroundStyle(isNew ? .cWhite : .cWhite)
                            .padding(5)
                            .padding(.horizontal,5)
                            .background(isNew ? .cGray1 : .main)
                            .cornerRadius(5)
                            .onTapGesture {
                                isNew = false
                            }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        Text("further_to_closer".localized)
                            .foregroundStyle(isFar ? .cWhite : .cWhite)
                            .padding(5)
                            .padding(.horizontal,5)
                            .background(isFar ? .main : .cGray1)
                            .cornerRadius(5)
                            .onTapGesture {
                                isFar = true
                            }
                        Spacer()
                        Text("closer_to_further".localized)
                            .foregroundStyle(isFar ? .cWhite : .cWhite)
                            .padding(5)
                            .padding(.horizontal,5)
                            .background(isFar ? .cGray1 : .main)
                            .cornerRadius(5)
                            .onTapGesture {
                                isFar = false
                            }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    HStack{
                        Text("best_to_worst".localized)
                            .foregroundStyle(isBest ? .cWhite : .cWhite)
                            .padding(5)
                            .padding(.horizontal,5)
                            .background(isBest ? .main : .cGray1)
                            .cornerRadius(5)
                            .onTapGesture {
                                isBest = true
                            }
                        
                        Spacer()
                    }
                    .padding(.horizontal)

                    HStack{
                        Text("worst_to_best".localized)
                            .foregroundStyle(isBest ? .cWhite : .cWhite)
                            .padding(5)
                            .padding(.horizontal,5)
                            .background(isBest ? .cGray1 : .main)
                            .cornerRadius(5)
                            .onTapGesture {
                                isBest = false
                            }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        SmallButtonComponent(action: {
                            
                        }, title: "confirm")
                        
                        Spacer()
                        
                        SmallButtonWithBorder(action: {
                            
                        }, title: "cancel")
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity)

    }
}

#Preview {
    VendorsMenuFilterCardView()
}

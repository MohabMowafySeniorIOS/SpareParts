//
//  HomeHeaderView.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/27/25.
//

import Foundation
import SwiftUI
struct HomeHeader: View {

    @State var Title: String
    @State var notificationCount: Int
    @Binding var isSheetPresented: Bool
    @Binding var naviToCarAuction: Bool
    @Binding var naviToCustomAd: Bool

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HStack {
                        NavigationLink(destination: NotificationsView()) {
                            Image(systemName: "bell.fill")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .overlay(
                                    alignment: .topTrailing,
                                    content: {
                                        ZStack {
                                            Circle()
                                                .fill(Color.red)
                                                .frame(width: 15, height: 15)
                                            Text(
                                                notificationCount > 99
                                                    ? "99+"
                                                    : "\(notificationCount)"
                                            )
                                            .foregroundColor(.white)
                                            .font(.system(size: 10))
                                            .minimumScaleFactor(0.5)
                                            .lineLimit(1)
                                            .padding(2)
                                        }
                                    })
                        }
                        .padding(.trailing,10)

                        Image(systemName: "plus.circle")
                            .foregroundColor(Color.white)
                            .font(.title)
                            .onTapGesture {
                                isSheetPresented.toggle()
                            }
                            .sheet(
                                isPresented: $isSheetPresented,
                                content: {
                                    ChooseAdTypeView(
                                        navigateToCarAuctions:
                                            $naviToCarAuction,
                                        navigateToCustomAd: $naviToCustomAd,
                                        isPresented: $isSheetPresented
                                    )
                                    .presentationDetents([.height(250)])
                                }
                            )
                            .fullScreenCover(isPresented: $naviToCustomAd) {
                                AddCustomAdView()
                            }
                            .fullScreenCover(isPresented: $naviToCarAuction) {
                                AddAdMainView()
                            }

                    }
                    Spacer()
                    HStack {
                        Image(.splashlogo)
                        
                            .resizable()
//                            .scaledToFit()
                            .cornerRadius(5)
                            .frame(width: 75, height: 35)
                    }
                    .frame(width: 85, height: 50)
                    .background(Color.cWhite)
                    .cornerRadius(5)
                    
                }.padding(.horizontal)

            }
            .frame(width: .infinity, height: 64)
            .background(Color.main)

            HStack {
                Spacer()
                Text("home".localized)
                    .foregroundColor(Color.white)
                    .font(.title2)
                Spacer()
            }

        }
    }
}
#Preview(body: {
    HomeHeader(Title: "home", notificationCount: 10, isSheetPresented: .constant(false), naviToCarAuction: .constant(false), naviToCustomAd: .constant(false))
})

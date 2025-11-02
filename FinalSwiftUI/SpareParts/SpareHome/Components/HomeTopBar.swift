//
//  HomeTopBar.swift
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
//
import SwiftUI


struct HomeTopBar: View {
    
    var userName: String
    @State var notificationCount: Int = 10
    var body: some View {
        ZStack{
            Circle()
                .fill(.cWhite)
                .frame(width: 50,height: 50)
                .overlay {
                    Text("LOGO")
                        .font(addFont(fontType: .Medium, size: 15))
                        .foregroundStyle(.cBlack)
                }
            HStack{
                Text("Hello".localized + " " + userName)
                    .foregroundStyle(.cWhite)
                Spacer()
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
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.main)
    }
}

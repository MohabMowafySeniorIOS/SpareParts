//
//  AppHeaderView.swift
//  FinalSwiftUI
//
//  Created by Mohab on 17/05/2025.
//

import SwiftUI

struct AppHeaderView: View {
    @State var Title : String
    var action: () -> Void // Action closure
    var body: some View {
        VStack {
            ZStack {
                Text(Title.localized).foregroundColor(Color.white)
                HStack {
                    Button(action : action) {
                        Image.RightArrow.padding().scaleEffect(x:appLanguage == "en" ? -1 : 1, y: 1)
                    }.frame(width: 32,height: 32)
                        .padding(16)
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 64)
        .background(Color.main)
        .environment(\.layoutDirection,appLanguage == "en" ? .leftToRight : .rightToLeft)
        
    }
}



struct AuthHeaderView: View {
    @State var Title : String
    var action: () -> Void // Action closure
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action : action) {
                        Image.authRightArrow.padding().scaleEffect(x:appLanguage == "ar" ? -1 : 1, y: 1)
                    }.frame(width: 32,height: 32)
                        .padding(16)
                    Spacer()
                }
            }
        }
        .frame(width: .infinity,height: 64)
       // .background(Color.main)
        .environment(\.layoutDirection,appLanguage == "en" ? .leftToRight : .rightToLeft)
        
    }
}



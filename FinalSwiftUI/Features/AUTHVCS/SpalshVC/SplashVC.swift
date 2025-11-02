//
//  SplashVC.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 04/12/2024.
//

import SwiftUI


struct SplashScreenView: View {
    @State private var showMainView = false

    var body: some View {
        if showMainView {
            if AuthService.userData?.token != nil{
                MainTabView()
            }else{
                LoginVC()
            }
            
        } else {
            ZStack {
                VStack(spacing: 16) {
                    Image.Splashlogo
                      .frame(width: 236, height: 106)
                      .scaledToFill()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                  showMainView = true
                }
            }
        }
    }
}


#Preview {
    SplashScreenView()
}

//
//  BindingHistoryView.swift
//  FinalSwiftUI
//
//  Created by Mohab on 18/05/2025.
//

import SwiftUI

struct BindingHistoryView: View {
    @Binding var path: NavigationPath
    var body: some View {
        AppHeaderView(Title: "سجل المزايدات") {
            path.removeLast()
        }
        VStack {
            ScrollView {
                VStack(spacing:16) {
                    
                        BindingHistoryCell()
                        BindingHistoryCell()
                        BindingHistoryCell()
                   
                   
                }.padding(16)
            }
            
            ContentButtonView(title: "Subscribe".localized) {
             
            }.padding()
        }
       
       
        
        Spacer()
    }
}

#Preview {
   // BindingHistoryView()
}

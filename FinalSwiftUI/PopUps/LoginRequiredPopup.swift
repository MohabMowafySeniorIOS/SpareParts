//
//  LoginRequiredPopup.swift
//  SpareParts
//
//  Created by Mohab on 12/03/2026.
//

import Foundation
import SwiftUI



struct LoginRequiredPopup: View {
    
    var onLogin: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "person.crop.circle.badge.exclamationmark")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("Login Required".localized)
                .font(.headline)
            
            Text("You need to login first to continue".localized)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            HStack {
                
                Button("Cancel".localized) {
                    onCancel()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)

                Button("login_button".localized) {
                    onLogin()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.MainColor)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
        }
        .padding()
       // .frame(maxWidth: 300)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding()
    }
}

#Preview {
    LoginRequiredPopup {
        print("")
    } onCancel: {
        print("")
    }

}

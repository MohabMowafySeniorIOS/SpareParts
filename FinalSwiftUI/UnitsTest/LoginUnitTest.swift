//
//  LoginUnitTest.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 02/12/2024.
//

import SwiftUI

class LoginUnitTestViewModel : ObservableObject {
    @Published var isPremium: Bool = false
    
    init(isPremium:Bool) {
        self.isPremium = isPremium
    }
}

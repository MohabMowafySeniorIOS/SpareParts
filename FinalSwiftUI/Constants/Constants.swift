//
//  Constants.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 19/12/2024.
//

import Foundation
import SwiftUI
let Google_Key = "AIzaSyBO9YeOCVVBLG74bNs14sxItJxruAbeQDU"
let appName = (Bundle.main.infoDictionary!["CFBundleName"] as? String) ?? ""
let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
let Currency = "R.S".localized
let hostName = "https://parts-car.e3gaz.com/api"
let appLanguage = Bundle.main.preferredLocalizations.first ?? "en"
let screenWidth = UIScreen.main.bounds.width

var languageManager = LanguageManager()
import SwiftUI
#if FREE_VERSION
let apiBaseUrl = "https://api.free.example.com"
#else
let apiBaseUrl = "https://api.paid.example.com"
#endif
struct ConstantKeys {
    static let shared = ConstantKeys()
   
    @State  var userName_title_label = "User Name".localized
    @State  var userName_Validation_label = "User Name Is Required".localized
    @State  var userName_PlaceHolder_label = "User Name".localized
    
    
}

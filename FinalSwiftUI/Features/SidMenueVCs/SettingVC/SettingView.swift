//
//  SettingView.swift
//  FinalSwiftUI
//
//  Created by Mohab on 19/05/2025.
//

import SwiftUI



struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var notificationsEnabled = true
    @EnvironmentObject var languageManager: LanguageManager
    @State private var selectedLanguage: SelectedLanguage = .eng
    @EnvironmentObject var navi: AppState
    
    

    var body: some View {
        VStack {
          
            AppHeaderView(Title: "Settings".localized) {
               dismiss()
            }

            Spacer().frame(height: 80)

            // Illustration
            Image("SettingIcon") // Add your image asset name here
                .resizable()
                .scaledToFit()
                .frame(height: 150)

            Spacer().frame(height: 30)

            // Notification Toggle
            HStack {
                Text("Notifications")
                    .font(addFont(fontType: .bold, size: 14))
                Spacer()
                HStack {
                    Text("Enabled")
                    settingRadioButton(isSelected: notificationsEnabled)
                        .onTapGesture {
                            notificationsEnabled = true
                        }

                    Text("Disable")
                    settingRadioButton(isSelected: !notificationsEnabled)
                        .onTapGesture {
                            notificationsEnabled = false
                        }
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 20)

            // Language Selection
           
            HStack {
                Text("Language".localized)
                    .font(addFont(fontType: .bold, size: 14))
                Spacer()
                HStack {
                    Text("Arabic".localized)
                    settingRadioButton(isSelected: selectedLanguage == .ar)
                        .onTapGesture {
                            selectedLanguage = .ar
                        }

                    Text("English".localized)
                    settingRadioButton(isSelected: selectedLanguage == .eng)
                        .onTapGesture {
                            selectedLanguage = .eng
                        }
                }
            }
            .padding(.horizontal)

            Spacer().frame(height: 30)

            // Save Button
            ContentButtonView(title: "Save".localized) {
                let languageCode = selectedLanguage == .eng ? "en" : "ar"
                languageManager.currentLanguage = languageCode

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    navi.goToHome()
                    dismiss()
                }
            }
            .padding(40)
            Spacer()
        }
    }
}

// Custom Radio Button View
struct settingRadioButton: View {
    var isSelected: Bool
    var body: some View {
        isSelected  ? (Image.selectIcon.frame(width: 16, height: 16)) : (Image.unSelectICon.frame(width: 16, height: 16))
            
    }
}

// Custom TabBar Item
struct TabBarItem: View {
    var title: String
    var systemImage: String

    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .font(.system(size: 20))
            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//       // SettingsView(path: <#Binding<NavigationPath>#>)
//    }
//}

import SwiftUI
enum SelectedLanguage {
    case eng, ar
}

struct SelectLanguageView: View {
    
    @State private var selectedLanguage: SelectedLanguage = .eng
    @EnvironmentObject var navi: AppState
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) var dismiss
    @Binding var restart: Bool

    
    var body: some View {
        ScrollView{
            VStack(spacing: 50){
                Image(.languageLogo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                HStack{
                    Text("choose language")
                        .foregroundStyle(.cBlack)
                        .font(.headline)
                    
                    Image(systemName: "globe")
                        .foregroundStyle(.main)
                        .font(.system(size: 25))
                }
                .padding(.bottom,10)
                
                HStack {
                    languageSelectionIcon(
                        image: Image(.enLang),
                        isSelected: selectedLanguage == .eng
                    )
                    .onTapGesture {
                        selectedLanguage = .eng
                    }

                    Spacer()

                    languageSelectionIcon(
                        image: Image(.arabLang),
                        isSelected: selectedLanguage == .ar
                    )
                    .onTapGesture {
                        selectedLanguage = .ar
                    }
                }
                .padding(.horizontal,60)
                .padding(.bottom,50)
                
                ContentButtonView(title: "save".localized) {
                    let languageCode = selectedLanguage == .eng ? "en" : "ar"
                    languageManager.currentLanguage = languageCode
                    dismiss()
                }
                
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
            
    }
}

struct languageSelectionIcon: View {
    let image: Image
    let isSelected: Bool

    var body: some View {
        HStack {
            image

            Circle()
                .stroke(style: StrokeStyle())
                .fill(isSelected ? .main : .cGray3)
                .frame(width: 15, height: 15)
                .overlay {
                    if isSelected {
                        Circle()
                            .fill(.main)
                            .padding(3)
                    }
                }
                .padding(.leading, 10)
        }
        
    }
}

#Preview {
    SelectLanguageView( restart: .constant(false))
}

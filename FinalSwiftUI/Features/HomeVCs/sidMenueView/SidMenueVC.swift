import StoreKit
import SwiftUI

enum SideMenuSelectedItem {
    case messages
    case settings
    case FAQ
    case About_us
    case Privacy
    case Terms
    case Policy
    case Contact
    case Profile
}

struct SidebarView: View {
    @State private var savedProfileImage: UIImage? = nil
  
    
    @Binding var showSidebar: Bool
    @Environment(\.dismiss) var dismiss

    // Callback to close the menu
    @EnvironmentObject var appState: AppState
    let onClose: () -> Void
    //    @Binding var navi: Bool
    @State private var isActive = false
    @Binding var itemSelected: SideMenuSelectedItem
    @State var showShareSheet = false
    @State var isFirst: Bool = true
    let normaltextinsideSideMenuColor: Color = .cBlack
    
    
    @StateObject private var viewModel = sidMenueViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    @State var showHome: Bool = false
    @State private var showAlert = false

    var body: some View {
        if showHome {
           SplashScreenView()
        } else {
            ZStack {
                errorToast
                if viewModel.isLoading == true {
                    LoaderView(rotation: $rotation, isLoading: $isLoading)
                        .frame(width: 100, height: 100)
                } else {
                    mainContent
                }
            }
            .onReceive(viewModel.$logOutModel) { Model in
                
                guard let userData = Model else { return }
                AuthService.userData = nil
                appState.logout()
            }
            .alert("You Should Login First".localized, isPresented: $showAlert) {
                Button("Log In".localized) {
                    // نفذ كود تسجيل الدخول هنا، مثلاً:
                    print("Go to login screen")
                    appState.logout()
                }

                Button("Cancel".localized, role: .cancel) {
                    // الإجراء عند الإلغاء
                    print("Cancelled")
                }
            }
        }
    }
    
    
    @ViewBuilder
    private var errorToast: some View {
        if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
            ToastView(message: errorMessage, backgroundColor: .red)
                .transition(.move(edge: .top))
                .zIndex(1)
        }
    }
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        ZStack(alignment: .leading) {
            // Dimmed background
            Color.clear
                .ignoresSafeArea()
                .onTapGesture {
                    onClose()
                }
            // Sidebar content
            HStack(spacing: 0) {
                VStack(spacing: 30) {
                    // Header
                    
                    HStack(alignment: .top) {
                        VStack {
                            if let image = savedProfileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                            } else if AuthService.userData?.token != nil {
                                RemoteImageView(imageUrl: AuthService.userData?.user?.profileImage ?? "")
                                  //  .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                            }
                            else {
                                Image(.portraitWhiteManIsolated)
                            }
                            if AuthService.userData?.user?.name != nil{
                                Text(AuthService.userData?.user?.name ?? "")
                            }else{
                                Text("user_name".localized)
                                    .font(addFont(fontType: .Regular, size: 18))
                            }
                            
                        }
                        .onTapGesture {
                            if AuthService.userData?.token != nil {
                                self.isActive = true
                                self.itemSelected = .Profile
                            }else {
                                showAlert = true
                            }
                           
                        }.navigationBarHidden(true)
                        Spacer()
                        Image(systemName: "xmark")
                            .foregroundStyle(.main)
                            .font(.system(size: 30))
                            .onTapGesture {
                                onClose()
                            }
                    }
                    .padding(.trailing)

                    Divider()
                    VStack(spacing: 24) {
                        SidMEnueView(
                            title: "menu_messages".localized,
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {
                            self.isActive = true
                            self.itemSelected = .messages
                        }.navigationBarHidden(true)

                        SidMEnueView(
                            title: "menu_settings".localized,
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {
                            self.isActive = true
                            self.itemSelected = .settings
                        }

                        SidMEnueView(
                            title: "menu_faq".localized,
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {
                            self.isActive = true
                            self.itemSelected = .FAQ
                        }

                        SidMEnueView(
                            title: "menu_about_us".localized,
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {
                            self.isActive = true
                            self.itemSelected = .About_us
                        }

                        SidMEnueView(
                            title: "menu_privacy".localized,
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {
                            self.isActive = true
                            self.itemSelected = .Privacy
                        }
                        SidMEnueView(
                            title: "menu_terms".localized,
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {
                            self.isActive = true
                            self.itemSelected = .Terms
                        }
                        SidMEnueView(
                            title: "menu_cancellation".localized,
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {
                            self.isActive = true
                            self.itemSelected = .Policy
                        }
                        SidMEnueView(
                            title: "menu_contact".localized,
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {
                            self.isActive = true
                            self.itemSelected = .Contact
                        }

                        SidMEnueView(
                            title: "menu_share".localized,
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {
                            self.showShareSheet = true
                        }

                        SidMEnueView(
                            title: "menu_rate".localized,
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {
                            if let scene = UIApplication.shared.connectedScenes
                                .first as? UIWindowScene
                            {
                                SKStoreReviewController.requestReview(in: scene)
                            }
                            //                                    if let url = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID?action=write-review") {
                            //                                        UIApplication.shared.open(url)
                            //                                    }
                        }

                        SidMEnueView(
                            title: AuthService.userData?.token == nil ? "Log In".localized : "menu_logout".localized, textColor: .cRed
                        )
                        .onTapGesture {
                            if AuthService.userData?.token == nil {
                                appState.logout()
                            }else {
                                viewModel.logOut()
                            }
                        }
                        .foregroundColor(Color.red)

                        if AuthService.userData?.token != nil {
                            SidMEnueView(
                                title: "menu_delete_account".localized,
                                textColor: .cRed
                            )
                            .onTapGesture {
                            
                                viewModel.DeleteAccount()
                            }
                            .foregroundColor(Color.red)
                        }
                      
                        SidMEnueView(
                            title: "menu_app_version".localized
                                + " \(appVersion ?? "")",
                            textColor: normaltextinsideSideMenuColor
                        )
                        .onTapGesture {

                            onClose()
                        }
                    }
                    .navigationBarHidden(true)
                    .navigationBarHidden(true)
                    .navigationDestination(isPresented: $isActive) {
                        switch itemSelected {
                        case .messages:
                            MessagesView().navigationBarHidden(true)
                        case .settings:
                            SettingsView().navigationBarHidden(true)
                        case .FAQ:
                            FAQScreen().navigationBarHidden(true)
                        case .About_us:
                            TermsVC(
                                itemType: .About,
                                pageTitle: "menu_about_us".localized
                            ).navigationBarHidden(true)
                        case .Privacy:
                            TermsVC(
                                itemType: .Privacy,
                                pageTitle: "menu_privacy".localized
                            ).navigationBarHidden(true)
                        case .Terms:
                            TermsVC(
                                itemType: .Terms,
                                pageTitle: "menu_terms".localized
                            ).navigationBarHidden(true)
                        case .Policy:
                            TermsVC(
                                itemType: .Policy,
                                pageTitle: "menu_cancellation".localized
                            ).navigationBarHidden(true)
                        case .Contact:
                            ContactUSView().navigationBarHidden(true)
                        case nil:
                            SplashScreenView().navigationBarHidden(true)
                        case .Profile:
                            ProfileVC().navigationBarHidden(true)
                        }

                    }
                }
                .padding(.leading, 16)
                .frame(maxHeight: .infinity)
                .frame(width: 250)
                .ignoresSafeArea()
                .background(Color(UIColor.systemBackground))
                .shadow(radius: 5)
                .transition(.move(edge: .leading))
                if showSidebar, !isFirst {
                    VStack {
                        Text("")
                        Color.clear
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.red)
                    .background(.black.opacity(0.3))
                    .onTapGesture {
                        onClose()
                    }
                }

            }
            Spacer()
        }
        .onAppear {
            isFirst = false
            showSidebar = true
            if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
               let image = UIImage(data: imageData) {
                savedProfileImage = image
            }
        }

        .frame(maxHeight: .infinity)
        .ignoresSafeArea()

    }
}

#Preview {
    SidebarView(
        showSidebar: .constant(true), onClose: {},
        itemSelected: .constant(.About_us))
}

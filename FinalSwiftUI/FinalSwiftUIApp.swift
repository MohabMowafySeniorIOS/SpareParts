//
//  FinalSwiftUIApp.swift
//  FinalSwiftUI
import SwiftUI
import IQKeyboardManagerSwift
import SwiftUI
import FirebaseCore
import UserNotifications
//import GoogleMaps
//import GooglePlaces
import FirebaseMessaging


@main
struct FinalSwiftUIApp: App {
    @StateObject private var viewModel = sidMenueViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var networkMonitor = NetworkMonitor()
    init() {
        UIView.appearance().overrideUserInterfaceStyle = .light
    }
   // @StateObject var appState = AppState()
    @StateObject var languageManager = LanguageManager()
    
    @StateObject var coordinator = AppState()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if networkMonitor.isConnected {
                    switch coordinator.currentScreen {
                    case .login:
                        LoginVC()
                            .environmentObject(coordinator)
                        
                    case .home:
                        MainTabView()
                            .environmentObject(coordinator)
                        
                    case .splash:
                        SplashScreenView().environmentObject(coordinator)
                    }
                   
                } else {
                    NoNetView(title: "Something went wrong! 🔧".localized, image: "Clip path group", Btn_Title: "Back To Home".localized)
                }
            }
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.2)) // Background color
            .onAppear {
                    print("Monitoring network status...")
                }
                //.environmentObject(coordinator)
                .environmentObject(languageManager)
                .environment(\.layoutDirection, languageManager.layoutDirection)
          
        }
    }
    
    
}


class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        showIQkeyboard()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerForPushNotifications()
//        GMSServices.provideAPIKey(Google_Key)
//        GMSPlacesClient.provideAPIKey(Google_Key)
        return true
    }
    
    func showIQkeyboard(){
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.toolbarConfiguration.tintColor = UIColor.MainColor
        // IQKeyboardManager.shared.keyboardAppearance = .dark
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarConfiguration.previousNextDisplayMode = .alwaysShow
        IQKeyboardManager.shared.deepResponderAllowedContainerClasses.append(UIStackView.self)
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardConfiguration.overrideAppearance = true
    }
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Permission granted: \(granted)")
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(token)")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
}







extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("User interacted with notification: \(response.notification.request.content.userInfo)")
        completionHandler()
    }
}

//class AppState: ObservableObject {
//    enum RootViewType {
//        case Splash
//        case Login
//        case Main
//    }
//    @Published var RootView : RootViewType = .Splash
//    @Published var mainTabSelection: Int = 4 // 4 = Home tab as default
//
//    func restartApp(RootView:RootViewType) {
//     
//        self.RootView = RootView
//       
//    }
//}
class AppState: ObservableObject {
    enum Screen {
        case splash
        case login
        case home
       
    }
    @Published var mainTabSelection: Int = 4 // 4 = Home tab as default
    @Published var currentScreen: Screen = .splash
    @Published var id = UUID()

    func goToHome() {
        currentScreen = .home
        id = UUID()
    }

    func goToSplash() {
        currentScreen = .splash
        id = UUID()
    }

    func logout() {
        currentScreen = .login
        id = UUID()
    }
}

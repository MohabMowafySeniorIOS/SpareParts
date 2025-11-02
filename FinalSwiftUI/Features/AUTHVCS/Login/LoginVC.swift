import SwiftUI
//import Combine


struct LoginVC: View {
   
    // MARK: NavigationVariable
    
    @State private var isActive = false
    @State private var isForget = false
    @State private var isRegister = false
   
    
    @StateObject private var viewModel = LoginViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    @State private var isNavigating = false
    @State private var showAlert = false
    @State private var validationError = ""
    
    // MARK: - Phone State
    
    @State private var phoneInput = ""
    var phoneTitleLabel = "Phone Number".localized
    @State private var phoneValidationLabel = "phone_number_required".localized
    @State private var isLabelHiddenPhone = true
    @State private var isRequiredPhone = true
    @State private var showNumberAlert: Bool = false
    
    // MARK: - Password State
    
    @State private var passwordInput = ""
    @State private var passwordTitleLabel = "".localized
    @State private var passwordValidationLabel = "password_required".localized
    @State private var isLabelHiddenPassword = true
    @State private var isRequiredPassword = true
    @State private var showPasswordAlert: Bool = false
    @State private var isForgetPassw = false
    // MARK: - View
   @EnvironmentObject var appState : AppState
    var body: some View {
        NavigationStack {
        
                ZStack {
                    errorToast
                    if viewModel.isLoading == true {
                        LoaderView(rotation: $rotation, isLoading: $isLoading)
                            .frame(width: 100, height: 100)
                    } else {
                        mainContent
                    }
                }
                .navigationDestination(isPresented: $isActive) {
                    OTPView(isForgetPass: $isForgetPassw, phone : $phoneInput).navigationBarHidden(true)
                }
                .navigationDestination(isPresented: $isForget) {
                    ForgetPassVc()
                }
                .navigationDestination(isPresented: $isRegister) {
                    RegisterVC()
                }
                .onReceive(viewModel.$userData) { Model in
                    guard let userData = Model else { return }
                   // self.showHome = true
                    appState.goToHome()
                }
                
         
            
        }
    }
    
    // MARK: - Error Toast
    
    @ViewBuilder
    private var errorToast: some View {
        if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
            ToastView(message: errorMessage, backgroundColor: .cRed)
                .transition(.move(edge: .top))
                .zIndex(0.1)
        }
    }
    
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(spacing: 51) {
                    logoSection
                    formSection
                }
            }
            .padding(16)
        }
        .mask(RoundedRectangle(cornerRadius: 0))
    }
    
    // MARK: - Logo Section
    
    private var logoSection: some View {
        VStack(spacing: 35) {
            Image.Splashlogo
                .resizable()
                .logoSize()
            
            Text("login_title".localized)
                .font(.custom(AppFont.bold.rawValue, size: 16))
                .foregroundColor(Color.TitleColor)
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: - Form Section
    
    private var formSection: some View {
        VStack(spacing: 120) {
            VStack(spacing: 24) {
                
                CustomMobileTextField(
                    text: $phoneInput,
                    Validation_label: $phoneValidationLabel,
                    is_validation_label: $isLabelHiddenPhone,
                    isPhoneNumber: true,
                    isSelectable: false,
                    showTitle: false,
                    placeholder: "phone_placeholder".localized
                )
                
                CustomePasswordTF(
                    text: $passwordInput,
                    title_label: $passwordTitleLabel,
                    Validation_label: $passwordValidationLabel,
                    is_validation_label: $isLabelHiddenPassword,
                    isSelectable: false,
                    showTitle: false,
                    placeholder: "password_placeholder".localized
                )
                
                Text("forgot_password".localized)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom(AppFont.Regular.rawValue, size: 14))
                    .foregroundColor(Color.TitleColor)
                    .onTapGesture {
                        isForget = true
                    }
            }
            
            buttonSection
        }
    }
    
    // MARK: - Button Section
        
    private var buttonSection: some View {
        VStack(spacing: 12) {
            
            ContentButtonView(title: "login_button".localized) {
                var isValid = true
                if !isNumberValid(text: phoneInput).0{
                    isLabelHiddenPhone = false
                    isValid = false
                }else{
                    isLabelHiddenPhone = true
                }
                if !isPasswordValid(password: passwordInput).0{
                    isLabelHiddenPassword = false
                   
                    isValid = false
                }else{
                    isLabelHiddenPassword = true
                }
                if isValid {
                    viewModel.fetchUsers(urlEndPoint: .Login, methodType: .post, parameters: .init(phone: phoneInput, password: passwordInput))
                }
                                
            }
            .padding(.horizontal)
            .padding(.horizontal)
            
            CustomeButtonWithBorderColor(title: "register_button".localized) {
               isRegister = true
            }
            .padding(.horizontal)
            .padding(.horizontal)
            
            CustomeButtonWithTextColor(title: "guest_button".localized) {
                appState.goToHome()
            }
        }
    }
}

#Preview {
   // LoginVC(showHome: false, appState: .constant(.lo))
}

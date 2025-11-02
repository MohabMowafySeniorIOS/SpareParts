//
//  VerificationCodeVC.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 18/12/2024.
//
import SwiftUI

struct OTPView: View {
    @Environment(\.dismiss) var dismiss
    @Binding  var isForgetPass : Bool
    @State private var isActive = false
    @Binding  var phone :String
    @State private var isPresented: Bool = false
    @State private var rotation: Double = 0
    @State private var isLoading = true
    @StateObject private var viewModel = VerificationViewModel()
    
    @State private var timerSeconds = 3
    @State private var isResendButtonEnabled = false
    @State private var timer: Timer? = nil
    
    @State private var code: String = ""
    @State private var text: String = ""
    
    private let slotCount: Int = 4
    private let maxLength: Int = 4
    private let defaultCharacter: String = "-"
    
    var onCompletion: ((String) -> Void)? = nil
    
    @State private var naviToChangePassword: Bool = false
    
//    init(slotCount: Int = 4, onCompletion: ((String) -> Void)? = nil) {
//        self.slotCount = slotCount
//        self.onCompletion = onCompletion
//    }
    
    var body: some View {
        NavigationStack {
//            if isActive {
//                MainTabView()
//            } else {
                ZStack {
                    NavigationLink("", destination: ChangePasswordView(otp: $code, phone: $phone), isActive: $naviToChangePassword)
                    if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
                        ToastView(message: errorMessage, backgroundColor: .red)
                            .transition(.move(edge: .top))
                            .zIndex(1)
                    }
                    
                    if viewModel.isLoading ?? false {
                        LoaderView(rotation: $rotation, isLoading: $isLoading)
                            .frame(width: 100, height: 100)
                    } else {
                        VStack(spacing: 50) {
                            AuthHeaderView(Title: "") {
                                dismiss()
                            }
                            headerView
                            codeInputSection
                            Spacer()
                        }
                    }
                }
                .onReceive(viewModel.$activateModel) { Model in
                    if viewModel.activateModel != nil {
                        dismiss()
                    }
                    
                }
            
                .onReceive(viewModel.$resendCodeData) { Model in
                    if (viewModel.resendCodeData != nil) {
                        startTimer()
                        viewModel.resendCodeData = nil
                    }
                    
                }
                
           // }
        }
        .navigationBarBackButtonHidden()
    }
    
    private var headerView: some View {
        VStack(spacing: 35) {
            Image.Splashlogo
                .resizable()
                .logoSize()
            
            VStack(spacing: 25) {
                Text("confirm_phone_number".localized)
                    .font(.custom(AppFont.bold.rawValue, size: 16))
                    .foregroundColor(Color.TitleColor)
                    .multilineTextAlignment(.center)
                
                VStack{
                    Text("verification_sent_to_number".localized)
                        .font(.custom(AppFont.Regular.rawValue, size: 14))
                        .foregroundColor(Color.DesColor)
                        .multilineTextAlignment(.center)
                    
                    Text("+966*********")
                        .font(.custom(AppFont.Regular.rawValue, size: 14))
                        .foregroundColor(Color.DesColor)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
    
    private var codeInputSection: some View {
        VStack {
            codeBoxes
            resendSection
                .padding(.top)
        }
        .padding()
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }
    
    private var codeBoxes: some View {
        ZStack {
            HStack(spacing: 8) {
                ForEach(0..<slotCount, id: \.self) { index in
                    Spacer()
                    Text(code.count > index ? String(code[code.index(code.startIndex, offsetBy: index)]) : defaultCharacter)
                        .foregroundStyle(.main)
                        .frame(width: 60, height: 60)
                        .font(addFont(fontType: .bold, size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(code.count > index ? Color.MainColor : .gray)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(code.count > index ? Color.MainColor : .gray, lineWidth: 1))
                        .background(code.count > index ? Color.blue.opacity(0.1) : Color.clear)
                    Spacer()
                }
            }
            .environment(\.layoutDirection,.leftToRight)
            .overlay(
                TextField("", text: $text)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .foregroundColor(.clear)
                    .accentColor(.clear)
                    .disableAutocorrection(true)
                    .opacity(0.01)
                    .onChange(of: code) { newValue in
                        code = String(newValue.prefix(slotCount))
                        if code.count == slotCount {
                            onCompletion?(code)
                        }
                    }
            )
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
            }
            
            TextField("", text: $code)
                .accentColor(.clear)
                .keyboardType(.numberPad)
                .foregroundColor(.clear)
                .padding()
                .frame(height: 48)
                .background(Color.clear)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.clear, lineWidth: 1))
                .onChange(of: code) { newValue in
                    if newValue.count > maxLength {
                        code = String(newValue.prefix(maxLength))
                        if isForgetPass {
                            naviToChangePassword = true
                        }else {
                            viewModel.VerifyAccount(urlEndPoint: .verify_phone, methodType: .post, parameters: .init(phone: phone,otp: code))
                        }
                       
                    }
                }
        }
    }
    
    private var resendSection: some View {
        VStack(spacing: 20) {
            Text("resend_code_in".localized + " \(timerSeconds) " + "seconds".localized)
                .font(.subheadline)
                .opacity(isResendButtonEnabled ? 0 : 1)
            
            
            if isResendButtonEnabled {
                Button(action: resendCode) {
                    Text("Resend Code".localized)
                        .foregroundColor(Color.gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                    
                }
            }
            Spacer()
            
            ContentButtonView(title: "confirm_button".localized) {
             
             
                    viewModel.VerifyAccount(urlEndPoint: .verify_phone, methodType: .post, parameters: .init(phone: phone,otp: code))
                
            }
            .padding(.horizontal,30)
            
        }
    }
    
    private func startTimer() {
        timerSeconds = 30
        isResendButtonEnabled = false
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timerSeconds > 0 {
                timerSeconds -= 1
            } else {
                isResendButtonEnabled = true
                timer?.invalidate()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func resendCode() {
        // Add resend logic here
        viewModel.ResendCode(urlEndPoint: .resend_otp, methodType: .post, parameters: .init(phone: phone))
       
       
    }
}

struct VerificationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView(isForgetPass: .constant(false), phone: .constant("dasdas"))
    }
}

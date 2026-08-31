//
//  WalletView.swift
//  SpareParts
//
//  Created by Mohab Mowafy on 25/06/2026.
//

import Foundation
import SwiftUI

import Foundation

struct ChargeWalletModel: Codable {
    let status: String?
    let message: String?
    let data: ChargeWalletData?
}

struct ChargeWalletData: Codable {
    let charge_id: Int?
    let transaction_id: String?
    let redirect_url: String?
    let action: String?
    let payment_method: String?
}

import Foundation

protocol WalletServiceProtocol {
    func chargeWallet(
        token: String,
        amount: Double,
        paymentMethod: String,
        brand: String
    ) async throws -> ChargeWalletModel
}

final class WalletService: WalletServiceProtocol {

    private let baseURL = "https://YOUR_DOMAIN.com"

    func chargeWallet(
        token: String,
        amount: Double,
        paymentMethod: String,
        brand: String
    ) async throws -> ChargeWalletModel {

        guard let url = URL(string: "\(baseURL)/client/wallet/charge") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.setValue(
            token,
            forHTTPHeaderField: "Authorization"
        )

        request.setValue(
            "application/x-www-form-urlencoded",
            forHTTPHeaderField: "Content-Type"
        )

        let body =
        "amount=\(amount)&payment_method=\(paymentMethod)&brand=\(brand)"

        request.httpBody = body.data(using: .utf8)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw NSError(
                domain: "",
                code: httpResponse.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey: "Server Error"
                ]
            )
        }

        return try JSONDecoder().decode(
            ChargeWalletModel.self,
            from: data
        )
    }
}



import SwiftUI
import WebKit

struct PaymentWebView: UIViewRepresentable {

    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(
        _ webView: WKWebView,
        context: Context
    ) {

        let request = URLRequest(url: url)

        webView.load(request)
    }
}

import SwiftUI

struct RechargeWalletSheet: View {

    @Environment(\.dismiss) private var dismiss

    @State private var amount = ""

    let onConfirm: (Double) -> Void

    var body: some View {

        VStack(spacing: 20) {

            Text("شحن المحفظة")
                .font(.title3)

            TextField(
                "ادخل المبلغ",
                text: $amount
            )
            .keyboardType(.decimalPad)
            .textFieldStyle(.roundedBorder)

            HStack {

                Button("إلغاء") {
                    dismiss()
                }

                Spacer()

                Button("تأكيد") {

                    guard let value = Double(amount),
                          value > 0 else {
                        return
                    }

                    dismiss()

                    onConfirm(value)
                }
            }
        }
        .padding()
        .presentationDetents([.height(250)])
    }
}

import Foundation

@MainActor
final class NewWalletViewModel: ObservableObject {

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var redirectURL: String?

    private let service: WalletServiceProtocol

    init(service: WalletServiceProtocol = WalletService()) {
        self.service = service
    }

    func chargeWallet(
        token: String,
        amount: Double
    ) {

        Task {

            isLoading = true

            do {

                let response = try await service.chargeWallet(
                    token: token,
                    amount: amount,
                    paymentMethod: "moyasar",
                    brand: "visa"
                )

                redirectURL = response.data?.redirect_url

            } catch {

                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }
}

struct NewWalletView: View {

    @StateObject private var viewModel = NewWalletViewModel()

    @State private var showRechargeDialog = false
    @State private var showPaymentScreen = false

    let token: String

    var body: some View {

        ZStack {

            VStack {

                Spacer()
            }

            VStack {

                Spacer()

                HStack {

                    Spacer()

                    Button {

                        showRechargeDialog = true

                    } label: {

                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(
                                width: 60,
                                height: 60
                            )
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }

            if viewModel.isLoading {

                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                ProgressView()
            }
        }
        .sheet(isPresented: $showRechargeDialog) {

            RechargeWalletSheet { amount in

                viewModel.chargeWallet(
                    token: token,
                    amount: amount
                )
            }
        }
        .onChange(of: viewModel.redirectURL) { _, value in

            if value != nil {
                showPaymentScreen = true
            }
        }
        .fullScreenCover(
            isPresented: $showPaymentScreen
        ) {

            if let urlString = viewModel.redirectURL,
               let url = URL(string: urlString) {

                PaymentWebView(url: url)
            }
        }
        .alert(
            "Error",
            isPresented: Binding(
                get: {
                    viewModel.errorMessage != nil
                },
                set: { _ in
                    viewModel.errorMessage = nil
                }
            )
        ) {

            Button("OK") {}

        } message: {

            Text(viewModel.errorMessage ?? "")
        }
    }
}

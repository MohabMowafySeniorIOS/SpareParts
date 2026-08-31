//
//  OnBoardingVC.swift
//  SpareParts
//
//  Created by Mohab on 06/03/2026.
//

import Foundation
import SwiftUI

struct OnboardingView: View {

    @ObservedObject var viewModel: OnBoardingViewModel
    init(viewModel: OnBoardingViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    @State private var index = 0

    var body: some View {

        VStack {

            HStack {
                Spacer()

                Button("Skip".localized) {
                    finishOnboarding()
                }.foregroundColor(Color.MainColor)
            }
            .padding(.horizontal)

            TabView(selection: $index) {

                ForEach(Array(onboardingData.enumerated()), id: \.offset) { i, item in

                    OnboardingPage(item: item)
                        .tag(i)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            ContentButtonView(title: index == onboardingData.count - 1 ? "Start".localized : "Next".localized) {
                if index < onboardingData.count - 1 {
                    index += 1
                } else {
                    finishOnboarding()
                }
            }
            .padding(.horizontal)
            .padding(.horizontal)


        }
    }

    func finishOnboarding() {
        viewModel.showAuth()
    }
}
struct OnboardingItem: Identifiable {
    let id = UUID()
    
    let image: String
    let title: String
    let desc: String
}
let onboardingData: [OnboardingItem] = [
   
    
    
    
    OnboardingItem(
        image: "on1",
        title: "Smart Parts Ordering with Drivak.",
        desc: "Enter your car details or VIN, specify the parts you need, and skip the hassle of searching."
    ),

    OnboardingItem(
        image: "on2",
        title: "Get Best Competitive Offers",
        desc: " Receive multiple quotes from certified dealers and scrap yards. Compare prices, conditions, and warranties easily."
    ),

    OnboardingItem(
        image: "on3",
        title: "Secure Payment & Delivery",
        desc: "Accept the best offer, pay securely through multiple options, and get your parts delivered straight to your doorstep anywhere in KSA"
    )
]


struct OnboardingPage: View {

    let item: OnboardingItem
    var body: some View {
        VStack(spacing: 20) {

            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(height: 220)

            Text(item.title.localized)
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text(item.desc.localized)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}

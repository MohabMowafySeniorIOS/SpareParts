//
//  MerchantProfileView.swift
//  SpareParts
//
//  Created by Mohab on 13/02/2026.
//

import Foundation
import SwiftUI

struct MerchantProfileView: View {
    @ObservedObject private var viewModel: MerchantProfileViewModel
    
    init(viewModel: MerchantProfileViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack {
            AppHeaderView(Title: "merchant.profile_title".localized) {
                viewModel.coordinator.disMiss()
            }
            scrollView
            Spacer()
            updateButton
        }
        
    }
    
    private var scrollView: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                
                HStack {
                    Spacer()
                    basicInfoSection
                    Spacer()
                }
                
                
                imagesSection
                
                descriptionSection
                
                addressSection
                
                commercialSection
                
                bankSection
                
                Spacer(minLength: 30)
            }
            .padding()
        }
        .background(Color(Color.backGroundColor))
    }
    
    private var updateButton: some View {
        ContentButtonView(title: "Update".localized) {
            viewModel.showUpdateFileBusniss()
        }.padding()
    }
}

#Preview {
    MerchantProfileView(viewModel: MerchantProfileViewModel(coordinator: MainCoordinator(appCoordinator: AppCoordinator())))
}


// MARK: Bank Section
extension MerchantProfileView {
    
    var bankSection: some View {
        VStack(spacing: 10) {
            
            SectionTitle("merchant.bank_info".localized)
            
            InfoRowTrader(title: "merchant.bank_name".localized, value: "")
            InfoRowTrader(title: "merchant.beneficiary_name".localized, value: "Mohammed Ibrahim".localized)
            InfoRowTrader(title: "merchant.account_number".localized, value: "1122")
            InfoRowTrader(title: "merchant.iban".localized, value: "1223 0889")
        }
    }
}




// MARK: Basic Info
extension MerchantProfileView {
    
    var basicInfoSection: some View {
        VStack(spacing: 10) {
            
            SectionTitle("merchant.basic_info".localized)
            
            InfoRowTrader(title: "merchant.name_ar".localized, value: "Mohammed Nasser Youssef")
            InfoRowTrader(title: "merchant.name_en".localized, value: "Mohammed Nasser Youssef")
            
            HStack {
                Text("merchant.logo")
                Spacer()
                Image("Add photo")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(12)
            }
        }
    }
}


// MARK: Images
extension MerchantProfileView {
    
    var imagesSection: some View {
        VStack(alignment: .trailing, spacing: 10) {
            
            SectionTitle("merchant.images_docs".localized)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<3) { _ in
                        Image("Add photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 90)
                            .clipped()
                            .cornerRadius(12)
                    }
                    Spacer()
                }
            }
        }
    }
}


// MARK: Description
extension MerchantProfileView {
    
    var descriptionSection: some View {
        VStack(spacing: 10) {
            HStack {
                SectionTitle("merchant.desc_ar".localized)
                Spacer()
            }
            
                Text("merchant.desc_ar_placeholder".localized)
                    .font(.footnote)
                    .foregroundColor(.secondary)
           
            
            HStack {
                SectionTitle("merchant.desc_en".localized)
                Spacer()
            }
           
           
            
            Text("merchant.desc_en_placeholder".localized)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}


// MARK: Address
extension MerchantProfileView {
    
    var addressSection: some View {
        VStack(spacing: 16) {
            
            SectionTitle("merchant.address_details".localized)
            
            InfoRowTrader(title: "merchant.country".localized, value: "Saudi Arabia")
            InfoRowTrader(title: "merchant.region".localized, value: "Riyadh")
            InfoRowTrader(title: "merchant.city".localized, value: "Al Rawdah")
            
            Button {
                
            } label: {
                Text("merchant.show_map".localized)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.MainColor)
                    .cornerRadius(25)
            }
        }
    }
}


// MARK: Commercial Register
extension MerchantProfileView {
    
    var commercialSection: some View {
        VStack(spacing: 10) {
            
            SectionTitle("merchant.commercial_register".localized)
            
            InfoRowTrader(title: "merchant.cr_number".localized, value: "1502503")
            
            Image("Add photo")
                .resizable()
                .scaledToFit()
                .frame(height: 140)
                .cornerRadius(12)
        }
    }
}


struct SectionTitle: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        
        Text(text)
            .font(.headline)
            .foregroundColor(.SecondaryColor)
    }
}

struct InfoRowTrader: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color.SecondaryColor)
            Spacer()
            Text(value)
           
        }
    }
}

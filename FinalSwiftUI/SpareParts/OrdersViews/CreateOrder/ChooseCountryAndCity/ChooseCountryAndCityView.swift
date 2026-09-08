//
//  AddCountryView.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 16/07/2025.
//

import SwiftUI

struct ChooseCountryAndCityView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var isCountryDropDownActive: Bool = false
    @State private var isCityDropDownActive: Bool = false
    
    @ObservedObject private var viewModel: ChooseCountryAndCityViewModel
    @Binding var countryAndCities: [CountryAndCitiesModel]
    
    init(
        viewModel: ChooseCountryAndCityViewModel,
        countryAndCities: Binding<[CountryAndCitiesModel]>
    ) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self._countryAndCities = countryAndCities
    }
    
    var body: some View {
        mainContent
            .navigationBarHidden(true)
            .onAppear {
                restoreSelectedData()
            }
    }
    
    // MARK: - Restore Selected Data
    
    private func restoreSelectedData() {
        guard let savedData = countryAndCities.first,
              let selectedCountry = savedData.country else {
            return
        }
        
        // Restore selected country
        viewModel.selectedCcountry = selectedCountry
        
        // Get previously selected city IDs
        let selectedCityIDs = Set(
            savedData.cities?.compactMap { $0.id } ?? []
        )
        
        // Fetch cities and restore selected cities
        viewModel.fetchCities(
            countryId: selectedCountry.id ?? 0,
            selectedCityIDs: selectedCityIDs
        )
    }
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        VStack {
            AppHeaderView(Title: "Filter".localized) {
                dismiss()
            }
            
            ShowViewState(state: viewModel.state) { Model in
                VStack {
                    scrollView
                    addButtonView
                }
            }
        }
        .background(
            Color(Color.backGroundColor)
        )
    }
    
    // MARK: - ScrollView
    
    private var scrollView: some View {
        ScrollView {
            countriesView
            citiesView
        }
    }
    
    // MARK: - Countries
    
    private var countriesView: some View {
        VStack {
            DropDownBar(
                isDropDownActive: $isCountryDropDownActive,
                title: "Choose Country".localized
            )
            .onTapGesture {
                isCountryDropDownActive.toggle()
            }
            
            if isCountryDropDownActive {
                VStack(alignment: .leading) {
                    ForEach(viewModel.countryArray, id: \.id) { item in
                        HStack {
                            SpareCityFilterBox(
                                isBoxActive: item.id == (viewModel.selectedCcountry?.id ?? 0),
                                city: item.name ?? ""
                            )
                            .onTapGesture {
                                selectCountry(item)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    // MARK: - Cities
    
    private var citiesView: some View {
        VStack {
            DropDownBar(
                isDropDownActive: $isCityDropDownActive,
                title: "Choose City".localized
            )
            .onTapGesture {
                isCityDropDownActive.toggle()
            }
            
            if isCityDropDownActive {
                VStack(alignment: .leading) {
                    ForEach(viewModel.cityArray.indices, id: \.self) { index in
                        HStack {
                            SpareCityFilterBox(
                                isBoxActive: viewModel.cityArray[index].isSelected,
                                city: viewModel.cityArray[index].name ?? ""
                            )
                            .onTapGesture {
                                viewModel.cityArray[index].toggleSelected()
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    // MARK: - Select Country
    
    private func selectCountry(_ country: CountryData) {
        viewModel.selectedCcountry = country
        
        // Close city dropdown
        isCityDropDownActive = false
        
        // Remove old cities
        viewModel.cityArray.removeAll()
        
        // Fetch new country's cities
        viewModel.fetchCities(
            countryId: country.id ?? 0,
            selectedCityIDs: []
        )
    }
    
    // MARK: - Add Button
    
    private var addButtonView: some View {
        HStack {
            SimpleSpareButton(
                buttonTitle: "add",
                action: {
                    saveSelection()
                },
                widthValue: 300,
                heightValue: 45
            )
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    // MARK: - Save Selection
    
    private func saveSelection() {
        guard let country = viewModel.selectedCcountry else {
            return
        }
        
        let cities = viewModel.cityArray.filter {
            $0.isSelected
        }
        
        let newObject = CountryAndCitiesModel(
            country: country,
            cities: cities
        )
        
        // Update existing selection instead of appending duplicates
        if countryAndCities.isEmpty {
            countryAndCities.append(newObject)
        } else {
            countryAndCities[0] = newObject
        }
        
        print("Selected Country:", country.name ?? "")
        print("Selected Cities:", cities)
        
        dismiss()
    }
}

//
//  AddCityCard.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 16/07/2025.
//

import SwiftUI
struct AddCityCard: View {
    var model: CountryAndCitiesModel
    var delete: ()->Void
    var body: some View {
        VStack(spacing:10){
            VStack(alignment:.leading){
                HStack(spacing:50){
                    VStack(alignment:.leading,spacing:10){
                        Image(systemName: "house")
                            .foregroundStyle(Color.MainColor)
                        
                        
                        Image(systemName: "house")
                            .foregroundStyle(Color.MainColor)
                    }
                    VStack(alignment:.leading,spacing:10){
                        Text(model.country?.name ?? "")
                            .foregroundStyle(Color.MainColor)
                        
               
                        Text(getCityName(cities: model.cities))
                            .foregroundStyle(Color.MainColor)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
            .onAppear {
               
              
            }
            
            SimpleSpareButton(buttonTitle: "Delete".localized, action: {
                delete()
            }, widthValue: 150, heightValue: 30)
            
        }
        .padding(10)
        .frame(width: 230)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle())
                .fill(Color.MainColor)
        }
        .padding(1)
    }
    
    func getCityName(cities: [CityData]?) -> String{
        var cityName = ""
        if let cities = model.cities {
             cityName = cities.map { ($0.name ?? "") }.joined(separator: ", ")
            
        }
        
        return cityName
    }
}


struct DetailsCityCard: View {
    var model: Target
    //var delete: ()->Void
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            detailRow(icon: "house", text: model.name ?? "")
            detailRow(icon: "house", text: getCityName(cities: model.cities))
        }
        .padding(16)
        .frame(width: 230)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
    }

    private func detailRow(icon: String, text: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(Color.MainColor)
            Spacer()
            Text(text)
                .font(addFont(fontType: .bold, size: 14))
                .foregroundStyle(Color.MainColor)
        }
    }

    func getCityName(cities: [CityData]?) -> String{
        var cityName = ""
        if let cities = model.cities {
             cityName = cities.map { ($0.name ?? "") }.joined(separator: ", ")

        }

        return cityName
    }
}

//
//  AddAddressView.swift
//  SpareParts
//
//  Created by Mohab on 13/02/2026.
//

//import Foundation
//import SwiftUI
//import GoogleMaps
//import CoreLocation
//
//// MARK: - Google Map
//
//struct GoogleMapView: UIViewRepresentable {
//    
//    @Binding var camera: GMSCameraPosition
//    
//    func makeUIView(context: Context) -> GMSMapView {
//        let mapView = GMSMapView(
//            frame: .zero,
//            camera: camera
//        )
//        
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//        
//        return mapView
//    }
//    
//    func updateUIView(
//        _ uiView: GMSMapView,
//        context: Context
//    ) {
//        uiView.animate(to: camera)
//    }
//}
//
//// MARK: - Address View
//
//struct AdditionalAddressDescribtionView: View {
//    
//    @State private var camera = GMSCameraPosition(
//        latitude: 24.7136,
//        longitude: 46.6753,
//        zoom: 16
//    )
//    
//    @State private var address = ""
//    @State private var details = ""
//    
//    @State private var isLoadingAddress = false
//    
//    @ObservedObject var viewModel: AdditionalAddressDescribtionViewModel
//    
//    init(
//        viewModel: AdditionalAddressDescribtionViewModel
//    ) {
//        _viewModel = ObservedObject(
//            wrappedValue: viewModel
//        )
//    }
//    
//    var body: some View {
//        
//        ZStack {
//            
//            // MARK: Google Map
//            
//            GoogleMapView(
//                camera: $camera
//            )
//            .ignoresSafeArea()
//            
//            // MARK: Center Pin
//            
//            Image(systemName: "mappin.circle.fill")
//                .font(.system(size: 44))
//                .foregroundColor(Color.MainColor)
//                .background(
//                    Circle()
//                        .fill(
//                            Color.MainColor.opacity(0.2)
//                        )
//                        .frame(
//                            width: 90,
//                            height: 90
//                        )
//                )
//            
//            VStack {
//                
//                headerView
//                
//                searchBar
//                    .padding(.horizontal)
//                    .padding(.top, 6)
//                
//                Spacer()
//                
//                bottomSheet
//            }
//        }
//        .onAppear {
//            getAddressFromMap()
//        }
//    }
//}
//
//// MARK: - Header
//
//extension AdditionalAddressDescribtionView {
//    
//    private var headerView: some View {
//        
//        AppHeaderView(
//            Title: "address_agenda".localized
//        ) {
//            viewModel.disMiss()
//        }
//    }
//}
//
//// MARK: - Search Bar
//
//extension AdditionalAddressDescribtionView {
//    
//    var searchBar: some View {
//        
//        HStack {
//            
//            Image(systemName: "magnifyingglass")
//                .foregroundColor(.gray)
//            
//            TextField(
//                "Search About Address".localized,
//                text: $address
//            )
//            .multilineTextAlignment(.trailing)
//            
//            Image(systemName: "location.fill")
//                .foregroundColor(
//                    Color.MainColor
//                )
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(14)
//        .shadow(
//            color: .black.opacity(0.15),
//            radius: 6
//        )
//    }
//}
//
//// MARK: - Bottom Sheet
//
//extension AdditionalAddressDescribtionView {
//    
//    var bottomSheet: some View {
//        
//        VStack(
//            alignment: .trailing,
//            spacing: 16
//        ) {
//            
//            Text(
//                "Additional description of the title".localized
//            )
//            .foregroundColor(
//                Color.MainColor
//            )
//            .font(.headline)
//            
//            TextEditor(
//                text: $details
//            )
//            .frame(height: 120)
//            .padding(8)
//            .scrollContentBackground(.hidden)
//            .background(Color.white)
//            .cornerRadius(14)
//            .shadow(
//                color: Color.black.opacity(0.06),
//                radius: 6,
//                x: 0,
//                y: 2
//            )
//            
//            HStack {
//                
//                // MARK: Automatic GPS
//                
//                SimpleSpareButton(
//                    buttonTitle: "automatic_gps".localized,
//                    action: {
//                        getCurrentLocation()
//                    },
//                    widthValue: 150,
//                    heightValue: 35
//                )
//                
//                Spacer()
//                
//                // MARK: Add Address
//                
//                SmallButtonWithBorder(
//                    action: {
//                        addAddress()
//                    },
//                    title: "add".localized
//                )
//                .disabled(
//                    isLoadingAddress ||
//                    address.trimmingCharacters(
//                        in: .whitespacesAndNewlines
//                    ).isEmpty
//                )
//            }
//            .padding(.horizontal)
//        }
//        .padding()
//        .background(
//            Color(.systemGray6)
//        )
//    }
//}
//
//// MARK: - Map Functions
//
//extension AdditionalAddressDescribtionView {
//    
//    /// Get address from current map center
//    private func getAddressFromMap() {
//        
//        let latitude = camera.target.latitude
//        let longitude = camera.target.longitude
//        
//        getAddress(
//            latitude: latitude,
//            longitude: longitude
//        )
//    }
//    
//    /// Reverse geocoding
//    private func getAddress(
//        latitude: Double,
//        longitude: Double
//    ) {
//        
//        isLoadingAddress = true
//        
//        let location = CLLocation(
//            latitude: latitude,
//            longitude: longitude
//        )
//        
//        CLGeocoder().reverseGeocodeLocation(
//            location
//        ) { placemarks, error in
//            
//            DispatchQueue.main.async {
//                
//                isLoadingAddress = false
//                
//                guard error == nil,
//                      let placemark = placemarks?.first
//                else {
//                    return
//                }
//                
//                var addressComponents: [String] = []
//                
//                if let name = placemark.name {
//                    addressComponents.append(name)
//                }
//                
//                if let subLocality = placemark.subLocality {
//                    addressComponents.append(
//                        subLocality
//                    )
//                }
//                
//                if let locality = placemark.locality {
//                    addressComponents.append(
//                        locality
//                    )
//                }
//                
//                if let administrativeArea =
//                    placemark.administrativeArea {
//                    
//                    addressComponents.append(
//                        administrativeArea
//                    )
//                }
//                
//                if let country =
//                    placemark.country {
//                    
//                    addressComponents.append(
//                        country
//                    )
//                }
//                
//                address = addressComponents.joined(
//                    separator: ", "
//                )
//            }
//        }
//    }
//}
//
//// MARK: - Current Location
//
//extension AdditionalAddressDescribtionView {
//    
//    private func getCurrentLocation() {
//        
//        guard let location =
//                CLLocationManager().location
//        else {
//            return
//        }
//        
//        camera = GMSCameraPosition(
//            latitude: location.coordinate.latitude,
//            longitude: location.coordinate.longitude,
//            zoom: 16
//        )
//        
//        getAddress(
//            latitude: location.coordinate.latitude,
//            longitude: location.coordinate.longitude
//        )
//    }
//}
//
//// MARK: - Add Address
//
//extension AdditionalAddressDescribtionView {
//    
//    private func addAddress() {
//        
//        let latitude = camera.target.latitude
//        let longitude = camera.target.longitude
//        
//        let addressText = address.trimmingCharacters(
//            in: .whitespacesAndNewlines
//        )
//        
//        let description = details.trimmingCharacters(
//            in: .whitespacesAndNewlines
//        )
//        
//        guard !addressText.isEmpty else {
//            return
//        }
//        
//        viewModel.AddAddressData(
//            paramter: .init(
//                is_default: "1",
//                title: addressText,
//                latitude: String(latitude),
//                longitude: String(longitude),
//                address_text: addressText,
//                description: description
//            )
//        )
//    }
//}

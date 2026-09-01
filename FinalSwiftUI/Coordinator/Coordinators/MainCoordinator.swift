//
//  MainCoordinatorView.swift
//  MyAuctions
//
//  Created by مهاب موافي on 12/13/25.
//

import Foundation
import SwiftUI

final class MainCoordinator: ObservableObject {

    @Published var path = NavigationPath()
       
    
    private let appCoordinator: AppCoordinator

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    
    // MARK: Home
    func showNotification() {
        path.append(MainRoute.showNotification)
    }
    
    /// Kept alive so pushing another screen (add car / add address ...) and coming
    /// back does not rebuild the view model and wipe the user's entered data.
    private var createOrderViewModel: CreateOrderViewModel?

    func createOrder(mainOrderType: CreateOrderType, specificVendor: Trader?) {
        createOrderViewModel = CreateOrderViewModel(coordinator: self, specificVendor: specificVendor)
        path.append(MainRoute.createOrder(mainOrderType: mainOrderType, specificVendor: specificVendor))
    }

    func createOrderViewModel(specificVendor: Trader?) -> CreateOrderViewModel {
        if let existing = createOrderViewModel {
            return existing
        }
        let newModel = CreateOrderViewModel(coordinator: self, specificVendor: specificVendor)
        createOrderViewModel = newModel
        return newModel
    }
    
//    func addPiece(pieces: Binding<[PartModel]>){
//        path.append(MainRoute.addPiece)
//    }
    
    func vendorDetails(rating: Double , vendorId: String) {
        path.append(MainRoute.vendorDetails(rating: rating, vendorId: vendorId))
    }
    func BanckAccountDetails(model: TransactionItem?) {
        path.append(MainRoute.BanckAccountDetails(model: model))
    }
    
    
    
    
    //MARK: MoreVC
    func restartApp(){
       
            appCoordinator.flow = .auth
        
       
    }
    
    func logOut(){
        AuthService.userData = nil
        appCoordinator.flow = .auth
    }

   
    
    func showMyCars() {
        path.append(MainRoute.MyCars)
    }
    
    func showGatWay(orderId: String, price: Double) {
        path.append(MainRoute.GatWay(orderId: orderId, price: price))
    }
    
    func showMyFileBusniss() {
        path.append(MainRoute.FileBusniss)
    }
    
    func showUpdateFileBusniss() {
        path.append(MainRoute.UpdateFileBusniss)
    }
    
    func showAddCars(carId: CarsData?) {
        path.append(MainRoute.addCar(carId: carId))
    }
    
    func showMyAddresses() {
        path.append(MainRoute.MyAddress)
    }
    
    func showAddAddresses(addressModel: AddressData?) {
        path.append(MainRoute.AddAddress(addressModel: addressModel))
    }
    
    func showWallet() {
        path.append(MainRoute.Wallet)
    }
    
    func showMessages() {
        path.append(MainRoute.messages)
    }
    
    func showChatView(roomId: String,title: String) {
        path.append(MainRoute.chatView(roomId: roomId,title: title))
    }
    
    
    func showSettings() {
        path.append(MainRoute.settings)
    }
    
    func showOrderDetails(orderId: String) {
        path.append(MainRoute.OrderDetailsView(orderId: orderId))
    }
    
    func showAboutUs(page: String) {
        path.append(MainRoute.About_us(page: page))
    }
    
    
    func showContact() {
        path.append(MainRoute.Contact)
    }
    
    func showProfile() {
        path.append(MainRoute.Profile)
    }
    
    func showFAQ() {
        path.append(MainRoute.FAQ)
    }
    
   
    func loginSuccess() {
        appCoordinator.flow = .main
    }
    
    func showUpdatePassword() {
        path.append(MainRoute.updatePassword)
    }
   
    func showPhoneScreen() {
        path.append(MainRoute.updatePhone)
    }
    
    func showOtpScreen(phone: String) {
        path.append(MainRoute.updateOtp(phone: phone))
    }
    
    func showWithDraw(){
        path.append(MainRoute.WithDraw)
        
    }
    
    func showOfferDetails(offerId: String, orderId: String, OfferModel: Offer) {
        path.append(MainRoute.offerDetails(offerId: offerId, orderId: orderId, OfferModel: OfferModel))
    }
    
    func showPaymentScreen(url: String, source: PaymentSource = .order) {
        path.append(MainRoute.paymentScreen(url: url, source: source))
    }
    
    func disMiss(){
        path.removeLast()
    }
}

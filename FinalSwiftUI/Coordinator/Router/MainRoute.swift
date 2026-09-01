//
//  MainRoute.swift
//  MyAuctions
//
//  Created by مهاب موافي on 12/13/25.
//

import Foundation

enum PaymentSource: Equatable, Hashable {
    case order
    case walletCharge
}

enum MainRoute: Equatable, Hashable {
  
    
    case createOrder(mainOrderType: CreateOrderType ,specificVendor: Trader?)
    //case addPiece
    case vendorDetails(rating: Double , vendorId: String)
    case BanckAccountDetails(model: TransactionItem?)
    case showNotification
    case OrderDetailsView(orderId: String)
    //MARK: MoreVC
    case MyCars
    case GatWay(orderId: String,price: Double)
    case FileBusniss
    case UpdateFileBusniss
    case MyAddress
    case AddAddress(addressModel: AddressData?)
    case Wallet
    case WithDraw
    case messages
    case chatView(roomId: String,title: String)
    case settings
    case FAQ
    case About_us(page: String)
    case Contact
    case Profile
    case addCar(carId: CarsData?)
    case updatePassword
    case updatePhone
    case updateOtp(phone: String)
    case offerDetails(offerId: String, orderId: String, OfferModel: Offer?)
    case paymentScreen(url: String, source: PaymentSource = .order)
}

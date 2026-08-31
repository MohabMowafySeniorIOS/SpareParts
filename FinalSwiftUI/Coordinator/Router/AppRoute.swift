//
//  AppRoute.swift
//  MyAuctions
//
//  Created by مهاب موافي on 12/12/25.
//

import Foundation

enum AppFlow: Hashable {
    case splash
    case language      // ← NEW: shown once after splash
    case onBoarding
    case auth
    case main
}

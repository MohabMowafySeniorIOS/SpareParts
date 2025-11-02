//
//  TermsModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/6/25.
//

import Foundation
import Foundation

struct TermsResponse: Codable {
    let data: TermsData?
}

struct TermsData: Codable {
    let content: String?
}

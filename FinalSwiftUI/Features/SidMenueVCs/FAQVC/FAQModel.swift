//
//  FAQModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/6/25.
//

import Foundation
import Foundation



struct FAQData: Codable {
    var faqs: [FAQ]?
}

struct FAQ: Identifiable, Codable {
    let id: UUID = UUID()
    let question: String
    let answer: String
    var isExpanded: Bool = false

//    mutating func changeExpandedState() {
//        isExpanded.toggle()
//    }
    // نحدد المفاتيح التي تأتي من JSON (بدون isExpanded)
    enum CodingKeys: String, CodingKey {
        case id, question, answer
    }
}

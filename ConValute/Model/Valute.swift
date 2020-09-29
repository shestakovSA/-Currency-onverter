//
//  Valute.swift
//  ConValute
//
//  Created by Сергей Шестаков on 21.09.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation
// MARK: - Currency
struct Currency: Codable {
    let Date, PreviousDate: Date?
    let PreviousURL: String?
    let Timestamp: Date?
    let Valute: [String: Valutes]
    
    private enum CodingKeys: String, CodingKey {
        case Date
        case PreviousDate
        case PreviousURL
        case Timestamp
        case Valute
    }
}

struct Valutes: Codable {
    let ID, NumCode, CharCode: String?
    let Nominal: Int?
    let Name: String?
    var Value, Previous: Double?
}

//
//  OOMeta.swift
//  HKCapture
//
//  Created by Charlie Holland on 10/31/25.
//

import Foundation
import HealthKit

struct OOMeta: Codable {
    enum MetaType: String, Codable {
        case string
        case double
        case date
        case quantity
    }
    var name: String
    var type: MetaType
    var stringValue: String?
    var doubleValue: Double?
    var dateValue: Date?
    var quantityValue: OOQuantity?

}

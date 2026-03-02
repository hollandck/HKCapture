//
//  OOQuantity.swift
//  HKCapture
//
//  Created by Charlie Holland on 11/2/25.
//

import Foundation
import HealthKit

struct OOQuantity: Codable {
    var value: Double
    var unit: String

    init(hkQuantity: HKQuantity) {
        let description = hkQuantity.description
        let comps = description.components(separatedBy: " ")
        value = Double(comps[0])!
        unit = String(comps[1])
    }

    init(value: Double, unit: String) {
        self.value = value
        self.unit = unit
    }
}

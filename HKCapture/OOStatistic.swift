//
//  OOQuantity.swift
//  HKCapture
//
//  Created by Charlie Holland on 10/29/25.
//

import Foundation
import HealthKit

struct OOStatistic: Codable {
    var id: UUID = UUID()
    var parentId: UUID
    var quantityType: HKQuantityTypeIdentifier
    var quantity: OOQuantity

    init(from: HKStatistics, parentId: UUID) {
        self.parentId = parentId
        let qty = from.quantityType
        quantityType = OOStatistic.typeIdentifier(from: from)
        let value: Double
        if qty.is(compatibleWith: .meter()) {
            if let qtyValue = from.sumQuantity() {
                value = qtyValue.doubleValue(for: .meter())
            } else {
                value = from.averageQuantity()!.doubleValue(for: .meter())
            }
            quantity = OOQuantity(value: value, unit: HKUnit.meter().unitString)
        } else if qty.is(compatibleWith: .count()) {
            value = from.sumQuantity()?.doubleValue(for: .count()) ?? from.averageQuantity()!.doubleValue(for: .count())
            quantity = OOQuantity(value: value, unit: HKUnit.count().unitString)
        } else if qty.is(compatibleWith: .degreeCelsius()) {
            value = from.sumQuantity()?.doubleValue(for: .degreeCelsius()) ?? from.averageQuantity()!.doubleValue(for: .degreeCelsius())
            quantity = OOQuantity(value: value, unit: HKUnit.degreeCelsius().unitString)
        } else if qty.is(compatibleWith: .kilocalorie()) {
            value = OOStatistic.doubleValue(stat: from, unit: .kilocalorie())
            quantity = OOQuantity(value: value, unit: HKUnit.kilocalorie().unitString)
        } else if qty.is(compatibleWith: .second()) {
            value =  OOStatistic.doubleValue(stat: from, unit: .second())
            quantity = OOQuantity(value: value, unit: HKUnit.second().unitString)
        } else if qty.is(compatibleWith: HKUnit(from: "count/min")) {
            value = OOStatistic.doubleValue(stat: from, unit: HKUnit(from: "count/min"))
            quantity = OOQuantity(value: value, unit: "count/min")
        } else if qty.is(compatibleWith: .watt()) {
            value =  OOStatistic.doubleValue(stat: from, unit: .watt())
            quantity = OOQuantity(value: value, unit: HKUnit.watt().unitString)
        } else if qty.is(compatibleWith: HKUnit(from: "m/s")) {
            let myUnit = HKUnit(from: "m/s")
            value = OOStatistic.doubleValue(stat: from, unit: myUnit)
            quantity = OOQuantity(value: value, unit: "m/s")
        } else {
            value = -1
            quantity = OOQuantity(value: value, unit: "unknown")
            print(qty)
        }
    }

    private static func doubleValue(stat: HKStatistics, unit: HKUnit) -> Double {
        if let qtyValue = stat.sumQuantity() {
            return qtyValue.doubleValue(for: unit)
        } else {
            return stat.averageQuantity()!.doubleValue(for: unit)
        }
    }

    private static func typeIdentifier(from: HKStatistics) -> HKQuantityTypeIdentifier {
        switch from.quantityType.identifier {
        case "HKQuantityTypeIdentifierActiveEnergyBurned":
            return .activeEnergyBurned
        case "HKQuantityTypeIdentifierBasalEnergyBurned":
            return .basalEnergyBurned
        case "HKQuantityTypeIdentifierDistanceCycling":
            return .distanceCycling
        case "HKQuantityTypeIdentifierDistanceSwimming":
            return .distanceSwimming
        case "HKQuantityTypeIdentifierDistanceWalkingRunning":
            return .distanceWalkingRunning
        case "HKQuantityTypeIdentifierHeartRate":
            return .heartRate
        case "HKQuantityTypeIdentifierRunningGroundContactTime":
            return .runningGroundContactTime
        case "HKQuantityTypeIdentifierRunningPower":
            return .runningPower
        case "HKQuantityTypeIdentifierRunningSpeed":
            return .runningSpeed
        case "HKQuantityTypeIdentifierRunningStrideLength":
            return .runningStrideLength
        case "HKQuantityTypeIdentifierRunningVerticalOscillation":
            return .runningVerticalOscillation
        case "HKQuantityTypeIdentifierStepCount":
            return .stepCount
        case "HKQuantityTypeIdentifierSwimmingStrokeCount":
            return .swimmingStrokeCount
        case "HKQuantityTypeIdentifierWaterTemperature":
            return .waterTemperature
        default:
            return HKQuantityTypeIdentifier.appleMoveTime
        }

    }
}

extension HKQuantityTypeIdentifier: @retroactive Codable {}

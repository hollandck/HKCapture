//
//  OOWorkout.swift
//  HKCapture
//
//  Created by Charlie Holland on 9/25/25.
//

import Foundation
import HealthKit
import AppleDeviceMap

struct OOWorkout: Codable {
    let id: UUID
    let startDate: Date
    let endDate: Date
    let duration: TimeInterval
    let workoutActivityType: HKWorkoutActivityType
    let workoutActivities: [String]
    let totalDistance: Double
    let metadata: [String: OOMeta]
    let allStatistics: [String: OOStatistic]
    let device: String

    init(workout: HKWorkout) {
        self.id = workout.uuid
        self.startDate = workout.startDate
        self.endDate = workout.endDate
        self.duration = workout.duration
        self.workoutActivityType = workout.workoutActivityType
        self.workoutActivities = [] //workout.workoutActivities.map { $0.workoutEvents[0].type. }
        self.totalDistance = workout.totalDistance?.doubleValue(for: .mile()) ?? 0
        if let rawMeta = workout.metadata {
            var resultMeta = [String: OOMeta]()
            rawMeta.keys.forEach {
                key in
                // NSString, NSNumber, NSDate, or HKQuantity
                let newMeta: OOMeta
                switch rawMeta[key] {
                case let str as String:
                    newMeta = OOMeta(name: key, type: .string, stringValue: str)
                case let dbl as Double:
                    newMeta = OOMeta(name: key, type: .double, doubleValue: dbl)
                case let dte as Date:
                    newMeta = OOMeta(name: key, type: .date, dateValue: dte)
                case let qty as HKQuantity:
                    newMeta = OOMeta(name: key, type: .quantity, quantityValue: OOQuantity(hkQuantity: qty))
                default:
                    newMeta = OOMeta(name: key, type: .string, stringValue: "unknown")
                }
                resultMeta[key] = newMeta
            }
            metadata = resultMeta
        } else {
            metadata = [:]
        }
        var workoutStats = [String: OOStatistic]()
        workout.allStatistics.forEach {
            let stat = OOStatistic(from: $0.value, parentId: workout.uuid)
            workoutStats[stat.quantityType.rawValue] = stat
        }
        self.allStatistics = workoutStats
        if let dev = workout.device, let hardware = dev.hardwareVersion, !hardware.isEmpty {
            self.device = hardware
        } else {
            self.device = "Unknown"
        }
    }
}

extension HKWorkoutActivityType: @retroactive Codable {

}

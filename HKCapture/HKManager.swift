//
//  HKManager.swift
//  PersonalDashboard
//
//  Created by Charlie Holland on 5/2/23.
//

import Foundation
import HealthKit
import SwiftUI

final class HKManager {
    static let instance = HKManager()

    var healthStore: HKHealthStore = HKHealthStore()
    var readingData = false
    private var workoutList = [HKWorkout]()
    private var inPreview = false

    let workoutTypes: [HKWorkoutActivityType] = [
        .walking,
        .running,
        .swimming,
        .cycling,
        .hiking
    ]

    private init() {}

    func setup() {
        if HKHealthStore.isHealthDataAvailable() {
            let read: Set = [
                .workoutType(),
                HKSeriesType.activitySummaryType(),
                HKSeriesType.workoutRoute(),
                HKSeriesType.workoutType()
            ]

            readingData = true
            healthStore.requestAuthorization(toShare: [], read: read) {
                success, error in
                if success {
                    Task {
                        try await self.readDataElements()
                    }
                } else {
                    print(error?.localizedDescription ?? "Unknown error")
                }
            }
        }
    }

    func parseWorkouts() {
        var ooWorkouts: [OOWorkout] = []
        workoutList.forEach { w in
            ooWorkouts.append(OOWorkout(workout: w))
        }
        do {
            let json = try JSONEncoder().encode(ooWorkouts)
            let jobj = try JSONSerialization.jsonObject(with: json)
            let pp = try JSONSerialization.data(withJSONObject: jobj, options: [.prettyPrinted, .sortedKeys])
            print(String(data: pp, encoding: .utf8)!)
        }
        catch {
            print(error)
        }

//        printMetaNames(ooWorkouts: ooWorkouts)
    }

    private func printMetaNames(ooWorkouts: [OOWorkout]) {
        var metaNames: Set<String> = []
        ooWorkouts.forEach {
            w in
            w.metadata.forEach {
                metaNames.insert($0.key)
            }
        }
        // Now case them
        metaNames.forEach {
            camelToWords($0)
        }
    }

    private func camelToWords(_ name: String) {
        var result = ""
        var upperCase = CharacterSet.uppercaseLetters
        upperCase.insert(charactersIn: "_")
        var filtered = name
        if filtered.hasPrefix("HK") {
            filtered = String(filtered.dropFirst(2))
        }
        var last: Character? = nil
        for char in filtered.unicodeScalars {
            if upperCase.contains(char), let uc = last?.unicodeScalars, !upperCase.contains(uc.first!) {
                result.append(" ")
            }
            result.append(Character(char))
            last = Character(char)
        }

        print("\(name) : \(result)")
    }

    func readDataElements() async throws {
        readingData = true
        let query = HKSampleQueryDescriptor(predicates: [.workout()], sortDescriptors: [.init(\.startDate, order: .reverse)], limit: Int(HKObjectQueryNoLimit))
        let workouts = try await query.result(for: healthStore)
//       let workouts = try await withThrowingTaskGroup(of: [HKWorkout].self, returning: [HKWorkout].self) {
//            group in
//            for wkoType in workoutTypes {
//                group.addTask { [self] in
//                    let sampleType = HKQuery.predicateForWorkouts(with: wkoType)
//                    let query = HKSampleQueryDescriptor(predicates: [.workout(sampleType)], sortDescriptors: [.init(\.startDate, order: .reverse)], limit: Int(HKObjectQueryNoLimit))
//                   return try await query.result(for: healthStore)
//                }
//            }
//            var localWorkouts = [HKWorkout]()
//            while let singleTypeWorkouts = try await group.next() {
//                    localWorkouts.append(contentsOf: singleTypeWorkouts)
//            }
//            return localWorkouts
//        }
        workoutList = workouts
        readingData = false
   }

    func workouts() -> [HKWorkout] {
        workoutList
    }
    
    private func dumpQtys(_ quantity: HKStatistics) {
        if let totalQty = quantity.sumQuantity() {
            print("Sum: \(totalQty)")
        }
        if let averageQty = quantity.averageQuantity() {
            print("Avg: \(averageQty)")
        }
    }

    // MARK: - workout constants and utilities
    func sumQuantity(_ qtyType: HKQuantityTypeIdentifier, workout: HKWorkout, unit: HKUnit) -> Double? {
        if let hktype = HKQuantityType.quantityType(forIdentifier: qtyType),
            let statistic = workout.allStatistics[hktype],
            let quantity = statistic.sumQuantity() {
            return quantity.doubleValue(for: unit)
        }
        return nil
    }

    func avgQuantity(_ qtyType: HKQuantityTypeIdentifier, workout: HKWorkout, unit: HKUnit) -> Double? {
        if let hktype = HKQuantityType.quantityType(forIdentifier: qtyType),
           let statistic = workout.allStatistics[hktype],
           let quantity = statistic.averageQuantity() {
            return quantity.doubleValue(for: unit)
        }
        return nil
    }
}

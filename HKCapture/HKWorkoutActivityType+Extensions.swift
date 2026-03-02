//
//  HKWorkoutActivityType+Extensions.swift
//  PersonalDashboard
//
//  Created by Charlie Holland on 9/18/25.
//

import Foundation
import HealthKit

extension HKWorkoutActivityType {
    var displayName: String {
        switch self {
        case .americanFootball:
            return "American Football"
        case .archery:
            return "Archery"
        case .australianFootball:
            return "Australian Football"
        case .badminton:
            return "Badminton"
        case .barre:
            return "Barre"
        case .baseball:
            return "Baseball"
        case .basketball:
            return "Basketball"
        case .bowling:
            return "Bowling"
        case .boxing:
            return "Boxing"
        case .cardioDance:
            return "Cardio Dance"
        case .climbing:
            return "Climbing"
        case .cooldown:
            return "Cooldown"
        case .coreTraining:
            return "Core Training"
        case .cricket:
            return "Cricket"
        case .crossCountrySkiing:
            return "Cross Country Skiing"
        case .crossTraining:
            return "Cross Training"
        case .curling:
            return "Curling"
        case .cycling:
            return "Cycling"
        case .discSports:
            return "Disc Sports"
        case .downhillSkiing:
            return "Downhill Skiing"
        case .elliptical:
            return "Elliptical"
        case .equestrianSports:
            return "Equestrian Sports"
        case .fencing:
            return "Fencing"
        case .fishing:
            return "Fishing"
        case .fitnessGaming:
            return "Fitness Gaming"
        case .flexibility:
            return "Flexibility"
        case .functionalStrengthTraining:
            return "Functional Strength Training"
        case .golf:
            return "Golf"
        case .gymnastics:
            return "Gymnastics"
        case .handCycling:
            return "Hand Cycling"
        case .handball:
            return "Handball"
        case .highIntensityIntervalTraining:
            return "High Intensity Interval Training"
        case .hiking:
            return "Hiking"
        case .hockey:
            return "Hockey"
        case .hunting:
            return "Hunting"
        case .jumpRope:
            return "Jump Rope"
        case .kickboxing:
            return "Kickboxing"
        case .lacrosse:
            return "Lacrosse"
        case .martialArts:
            return "Martial Arts"
        case .mindAndBody:
            return "Mind And Body"
        case .mixedCardio:
            return "Mixed Cardio"
        case .other:
            return "Other"
        case .paddleSports:
            return "Paddle Sports"
        case .pickleball:
            return "Pickleball"
        case .pilates:
            return "Pilates"
        case .play:
            return "Play"
        case .preparationAndRecovery:
            return "Preparation And Recovery"
        case .racquetball:
            return "Racquetball"
        case .rowing:
            return "Rowing"
        case .rugby:
            return "Rugby"
        case .running:
            return "Running"
        case .sailing:
            return "Sailing"
        case .skatingSports:
            return "Skating Sports"
        case .snowSports:
            return "Snow Sports"
        case .snowboarding:
            return "Snowboarding"
        case .soccer:
            return "Soccer"
        case .socialDance:
            return "Social Dance"
        case .softball:
            return "Softball"
        case .squash:
            return "Squash"
        case .stairClimbing:
            return "Stair Climbing"
        case .stairs:
            return "Stairs"
        case .stepTraining:
            return "Step Training"
        case .surfingSports:
            return "Surfing Sports"
        case .swimBikeRun:
            return "Swim Bike Run"
        case .swimming:
            return "Swimming"
        case .tableTennis:
            return "Table Tennis"
        case .taiChi:
            return "Tai Chi"
        case .tennis:
            return "Tennis"
        case .trackAndField:
            return "Track And Field"
        case .traditionalStrengthTraining:
            return "Traditional Strength Training"
        case .transition:
            return "Transition"
        case .underwaterDiving:
            return "Underwater Diving"
        case .volleyball:
            return "Volleyball"
        case .walking:
            return "Walking"
        case .waterFitness:
            return "Water Fitness"
        case .waterPolo:
            return "Water Polo"
        case .waterSports:
            return "Water Sports"
        case .wheelchairRunPace:
            return "Wheelchair Run Pace"
        case .wheelchairWalkPace:
            return "Wheelchair Walk Pace"
        case .wrestling:
            return "Wrestling"
        case .yoga:
            return "Yoga"
        default:
            return "Unknown"
        }
    }
}

struct WorkoutTypeExtension {
    static let nameActivityMap: [String: HKWorkoutActivityType] = [
        "American Football": .americanFootball,
        "Archery": .archery,
        "Australian Football": .australianFootball,
        "Badminton": .badminton,
        "Barre": .barre,
        "Baseball": .baseball,
        "Basketball": .basketball,
        "Bowling": .bowling,
        "Boxing": .boxing,
        "Cardio Dance": .cardioDance,
        "Climbing": .climbing,
        "Cooldown": .cooldown,
        "Core Training": .coreTraining,
        "Cricket": .cricket,
        "Cross Country Skiing": .crossCountrySkiing,
        "Cross Training": .crossTraining,
        "Curling": .curling,
        "Cycling": .cycling,
        "Disc Sports": .discSports,
        "Downhill Skiing": .downhillSkiing,
        "Elliptical": .elliptical,
        "Equestrian Sports": .equestrianSports,
        "Fencing": .fencing,
        "Fishing": .fishing,
        "Fitness Gaming": .fitnessGaming,
        "Flexibility": .flexibility,
        "Functional Strength Training": .functionalStrengthTraining,
        "Golf": .golf,
        "Gymnastics": .gymnastics,
        "Hand Cycling": .handCycling,
        "Handball": .handball,
        "High Intensity Interval Training": .highIntensityIntervalTraining,
        "Hiking": .hiking,
        "Hockey": .hockey,
        "Hunting": .hunting,
        "Jump Rope": .jumpRope,
        "Kickboxing": .kickboxing,
        "Lacrosse": .lacrosse,
        "Martial Arts": .martialArts,
        "Mind And Body": .mindAndBody,
        "Mixed Cardio": .mixedCardio,
        "Other": .other,
        "Paddle Sports": .paddleSports,
        "Pickleball": .pickleball,
        "Pilates": .pilates,
        "Play": .play,
        "Preparation And Recovery": .preparationAndRecovery,
        "Racquetball": .racquetball,
        "Rowing": .rowing,
        "Rugby": .rugby,
        "Running": .running,
        "Sailing": .sailing,
        "Skating Sports": .skatingSports,
        "Snow Sports": .snowSports,
        "Snowboarding": .snowboarding,
        "Soccer": .soccer,
        "Social Dance": .socialDance,
        "Softball": .softball,
        "Squash": .squash,
        "Stair Climbing": .stairClimbing,
        "Stairs": .stairs,
        "Step Training": .stepTraining,
        "Surfing Sports": .surfingSports,
        "Swim Bike Run": .swimBikeRun,
        "Swimming": .swimming,
        "Table Tennis": .tableTennis,
        "Tai Chi": .taiChi,
        "Tennis": .tennis,
        "Track And Field": .trackAndField,
        "Traditional Strength Training": .traditionalStrengthTraining,
        "Transition": .transition,
        "Underwater Diving": .underwaterDiving,
        "Volleyball": .volleyball,
        "Walking": .walking,
        "Water Fitness": .waterFitness,
        "Water Polo": .waterPolo,
        "Water Sports": .waterSports,
        "Wheelchair Run Pace": .wheelchairRunPace,
        "Wheelchair Walk Pace": .wheelchairWalkPace,
        "Wrestling": .wrestling,
        "Yoga": .yoga
        ]
}

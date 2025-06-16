//
//  Workouts.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/13/25.
//

import Foundation

class Workout: Identifiable {
    let id: UUID
    let name: String
    let type: String
    
    init(id: UUID = UUID(), name: String, type: String) {
        self.id = id
        self.name = name
        self.type = type
    }
}

class StrengthWorkout: Workout {
    let exercises: [ExerciseDetails]
    let sets: Int
    let reps: Int
    let restTime: String

    init(name: String, exercises: [ExerciseDetails], sets: Int, reps: Int, restTime: String) {
        self.exercises = exercises
        self.sets = sets
        self.reps = reps
        self.restTime = restTime
        super.init(name: name, type: "strength")
    }
}

class HIITWorkout: Workout {
    let exercises: [ExerciseDetails]
    let intervalMinutes: Int
    let intervalSeconds: Int
    let rounds: Int

    init(name: String, exercises: [ExerciseDetails], intervalMinutes: Int, intervalSeconds: Int, rounds: Int) {
        self.exercises = exercises
        self.intervalMinutes = intervalMinutes
        self.intervalSeconds = intervalSeconds
        self.rounds = rounds
        super.init(name: name, type: "hiit")
    }
}

class RunWorkout: Workout {
    let distanceInMiles: Double
    let durationInMinutes: Double
    let targetPace: String

    init(name: String, distance: Double, duration: Double, pace: String) {
        self.distanceInMiles = distance
        self.durationInMinutes = duration
        self.targetPace = pace
        super.init(name: name, type: "run")
    }
}

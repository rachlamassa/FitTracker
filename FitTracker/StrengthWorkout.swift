//
//  StrengthWorkout.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/21/25.
//
import Foundation

class StrengthWorkout: Workout {
    let exercises: [StrengthExercise]
    let restTime: String

    init(name: String, exercises: [StrengthExercise], restTime: String) {
        self.exercises = exercises
        self.restTime = restTime
        super.init(name: name, type: .strength)
    }
}

class StrengthExercise: Identifiable {
    // name, sets, reps, weight
    var exercise: ExerciseDetails?
    let sets: Int
    let reps: Int
    let weight: Int
    
    init(exercise: ExerciseDetails, sets: Int, reps: Int, weight: Int) {
        self.exercise = exercise
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
}


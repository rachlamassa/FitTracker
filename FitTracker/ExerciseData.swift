//
//  ExerciseData.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/26/25.
//

import Foundation

class ExerciseData: Identifiable {
    var id = UUID()
    var exerciseData: Exercise // takes from struct

    init(id: UUID = UUID(), exerciseData: Exercise) {
        self.id = id
        self.exerciseData = exerciseData
    }
}

class StrengthExerciseData: ExerciseData {
    var sets: Int
    var reps: Int
    var weight: Int
    
    init(
        id: UUID = UUID(),
        exerciseData: Exercise,
        sets: Int,
        reps: Int,
        weight: Int
    ) {
        self.sets = sets
        self.reps = reps
        self.weight = weight
        super.init(id: id, exerciseData: exerciseData)
    }
}

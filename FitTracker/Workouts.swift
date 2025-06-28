//
//  Workouts.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/26/25.
//

import Foundation

class Workout: Identifiable {
    var id = UUID()
    var name: String
    var exercises: [ExerciseData]
    
    init(id: UUID = UUID(), name: String, exercises: [ExerciseData]) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
}



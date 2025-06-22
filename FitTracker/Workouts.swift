//
//  Workouts.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/13/25.
//

import Foundation

enum WorkoutType {
    case strength
}

class Workout: Identifiable {
    let id: UUID
    let name: String
    let type: WorkoutType
    
    init(id: UUID = UUID(), name: String, type: WorkoutType) {
        self.id = id
        self.name = name
        self.type = type
    }
}

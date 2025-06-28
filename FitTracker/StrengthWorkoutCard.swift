//
//  StrengthWorkoutCard.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/28/25.
//

import SwiftUI

struct StrengthWorkoutCard: View {
    var workout: Workout
    var body: some View {
        HStack (spacing: 10){
            ZStack {
                Circle()
                    .foregroundStyle(Color("tint_green"))
                    .frame(width: 44, height: 44)
                Image(systemName: "dumbbell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding()
                    .foregroundStyle(Color(.white))
            }
            VStack (alignment: .leading, spacing: 5){
                Text(workout.name)
                    .foregroundColor(Color("tint_blue"))
                    .fontWeight(.semibold)
                if workout.exercises.count > 0 {
                    Text(workout.exercises.count > 1 ? "\(workout.exercises.count) Exercises" : "\(workout.exercises.count) Exercise")
                }

                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(15)

        
    }
}

#Preview {
    StrengthWorkoutCard(workout: Workout(name: "Push", exercises: []))
}

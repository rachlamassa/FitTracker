//
//  CreateWorkoutView.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/10/25.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @State private var workoutName: String = ""
    private let numsArray = Array(1...59)
    @State private var numSets: Int = 1
    @State private var numReps: Int = 1
    @State private var numMins: Int = 0
    @State private var numSecs: Int = 0
    @State private var switchMetric = false
    @State private var exerciseExists: Bool = false // temp bool
    
    @State private var workouts: [Workouts] = [
        Workouts(name: "Push Workout"),
        Workouts(name: "Pull Workout"),
        Workouts(name: "Legs"),
        Workouts(name: "HIIT"),
        Workouts(name: "Stretching")
    ]
    
    var body: some View {
        VStack (spacing: 20){
            headerSection
            //        ScrollView {
            workoutNameForm
            addExercise
                .padding(.horizontal)
            
            //        }
            selectedExercises
        }
        // TODO: list of exercises
    }
    
    private var headerSection: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
                Spacer()
            }
            .font(.system(size: 16))
            HStack (spacing: 8) {
                Text("Create Workout")
            }
            .font(.system(size: 20))
        }
        .padding()
        .fontWeight(.medium)
        .foregroundColor(.black)
    }
    
    private var workoutNameForm: some View {
        VStack(alignment: .leading) {
            Text("Workout Name")
            TextField("Enter workout name", text: $workoutName)
        }
        .padding()
    }
    
    private var addExercise: some View {
        VStack (spacing: 10){
            // TODO: custom long button
            if !exerciseExists {
                Button {
                    exerciseExists.toggle()
                } label: {
                    Text("+ Add Exercise")
                        .fontWeight(.medium)
                        .padding(20)
                        .foregroundStyle(.white)
                        .background(.black)
                        .cornerRadius(20)
                }
            } else {
                ExerciseCard(context: .browse)
                HStack {
                    Spacer()
                    if !switchMetric {
                        Menu (String(numSets) + " Sets"){
                            ForEach(numsArray, id: \.self) { num in
                                Button {
                                    numSets = num
                                } label: {
                                    Text(String(num))
                                }
                            }
                        }
                        .fontWeight(.medium)
                        .padding()
                    } else {
                        Menu (String(numMins) + " min"){
                            ForEach(numsArray, id: \.self) { num in
                                Button {
                                    numMins = num
                                } label: {
                                    Text(String(num))
                                }
                            }
                        }
                        .fontWeight(.medium)
                        .padding()
                    }
                    Spacer()
                    if !switchMetric {
                        Menu (String(numReps) + " Reps"){
                            ForEach(numsArray, id: \.self) { num in
                                Button {
                                    numReps = num
                                } label: {
                                    Text(String(num))
                                }
                            }
                        }
                        .fontWeight(.medium)
                        .padding()
                    } else {
                        Menu (String(numSecs) + " sec"){
                            ForEach(numsArray, id: \.self) { num in
                                Button {
                                    numSecs = num
                                } label: {
                                    Text(String(num))
                                }
                            }
                        }
                        .fontWeight(.medium)
                        .padding()
                    }
                    Spacer()
                    Button {
                        switchMetric.toggle()
                    } label: {
                        Image(systemName: "shuffle")
                    }
                    Spacer()
                    Button {
                        exerciseExists.toggle()
                        numSets = 1
                        numReps = 1
                    } label: {
                        Text("+")
                    }
                    .fontWeight(.medium)
                    .padding()
                    Spacer()
                }
            }
        }
        .frame(height: 100)
    }
    
    private var selectedExercises: some View {
        VStack (alignment: .leading){
            Text("Selected Workouts")
                .padding()

            List {
                ForEach(workouts) { workout in
                    ExerciseCard(context: .browse)
                        .listRowBackground(Color.clear)
                        .swipeActions(edge: .trailing) {
                            Button {
                                deleteWorkout(workout)
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 20, height: 20)
                                    Image(systemName: "trash.fill")
                                        .background(.red)
                                }
                            }
                            .tint(Color.red)
                            Button {
                                deleteWorkout(workout)
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 20, height: 20)
                                    Image(systemName: "pencil")
                                        .background(.red)
                                }
                            }
                            .tint(Color.blue)
                        }
                        
                }
            }
            .listStyle(.plain)
            .background(Color(.clear))
        }
    }
    
    private func deleteWorkout(_ workout: Workouts) {
            if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
                workouts.remove(at: index)
            }
        }
}

#Preview {
    CreateWorkoutView()
}

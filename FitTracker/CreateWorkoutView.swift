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
    
    @State private var workoutMetrics: [String: Int] = [:]
    
    @State private var exerciseExists: Bool = false // temp bool
    @State private var workout: Workout = Workout(name: "Push", type: "strength") // to accomodate hit and strength
    
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
        .background(Color(.systemGroupedBackground))
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
        .background(Color(.white))
    }
    
    private var workoutNameForm: some View {
        VStack(alignment: .leading) {
            Text("Workout Name")
            TextField("Enter workout name", text: $workoutName)
        }
        .padding()
    }
    
    private var addExercise: some View {
        VStack {
            if !exerciseExists {
                addExerciseButton
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .scale.combined(with: .opacity)
                    ))
            } else {
                exerciseInputSection
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
            }
        }
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.45), value: exerciseExists)
    }
    
    private var addExerciseButton: some View {
        Button {
            withAnimation {
                exerciseExists.toggle()
            }
        } label: {
            Text("+ Add Exercise")
                .fontWeight(.medium)
                .padding(20)
                .foregroundStyle(.white)
                .background(.black)
                .cornerRadius(20)
        }
    }
    
    private var exerciseInputSection: some View {
        VStack(spacing: 10) {
            ExerciseCard(context: .browse)
            HStack {
                Spacer()
                Menu("\(numSets) Sets") {
                    ForEach(numsArray, id: \.self) { num in
                        Button {
                            numSets = num
                        } label: {
                            Text("\(num)")
                        }
                    }
                }
                .fontWeight(.medium)
                .padding()

                Spacer()

                Menu("\(numReps) Reps") {
                    ForEach(numsArray, id: \.self) { num in
                        Button {
                            numReps = num
                        } label: {
                            Text("\(num)")
                        }
                    }
                }
                .fontWeight(.medium)
                .padding()

                Spacer()

                Button {
                    withAnimation {
                        exerciseExists = false
                        numSets = 1
                        numReps = 1
                    }
                } label: {
                    Text("+")
                }
                .fontWeight(.medium)
                .padding()

                Spacer()
            }
        }
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

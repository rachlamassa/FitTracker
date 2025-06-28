//
//  WorkoutCreationView.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/26/25.
//

import SwiftUI

struct WorkoutCreationView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedExercise: Exercise? = nil
    @State private var showSelectExercise: Bool = false
    
    // workout name
    @State private var workoutName: String = ""
    
    // exercise input variables (sets, reps, weight)
    @State private var currSets: Int = 1
    @State private var currReps: Int = 1
    @State private var currWeight: Int = 0
    
    private let numsArray = Array(1...100)
    
    // strength exercise list
    @State private var strengthExerciseList: [StrengthExerciseData] = []
    
    var body: some View {
        VStack (spacing: 30){
            headerSection
            workoutNameField
            addExercise
            selectedExercises
            
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showSelectExercise) {
            ExerciseSelectionView(showSelectExercise: $showSelectExercise, selectedExercise: $selectedExercise)
        }
        .background(Color(.systemGray6))
    }
    
    private var headerSection: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Button {
                    // create workout
                    // let newWorkout = Workout(exercises: strengthExerciseList)
                    dismiss()
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color("tint_blue"))
                }
            }
            Text("Create Workout")
                .font(.title)
        }
        .padding()
        .foregroundColor(Color("tint_blue"))

    }
    
    private var workoutNameField: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Workout Name")
                .font(.title3)
                .foregroundColor(Color("tint_blue"))
            TextField("Enter workout name", text: $workoutName)
                .padding(.leading, 10)
                .frame(height: 45)
                .background(Color(.white).opacity(0.45))
                .cornerRadius(15)
        }
        .padding()
    }
    
    private var addExercise: some View {
            VStack {
                if selectedExercise == nil {
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
            .animation(.easeInOut(duration: 0.45), value: (selectedExercise == nil))
            .frame(height: 125)
        }
        
        private var addExerciseButton: some View {
            Button {
                withAnimation {
                    showSelectExercise = true
                }
            } label: {
                Text("+ Add Exercise")
                    .fontWeight(.medium)
                    .padding(20)
                    .foregroundStyle(.white)
                    .background(Color("tint_blue"))
                    .cornerRadius(15)
            }
        }
    
    
    private var exerciseInputSection: some View {
            VStack(spacing: 10) {
                ExerciseCard(exercise: selectedExercise!)
                HStack {
                    Spacer()
                    Menu(currSets > 1 ? "\(currSets) Sets" : "\(currSets) Set") {
                        ForEach(numsArray, id: \.self) { num in
                            Button {
                                currSets = num
                            } label: {
                                Text("\(num)")
                            }
                        }
                    }
                    .foregroundColor(Color("tint_blue"))
                    .padding()

                    Spacer()

                    Menu(currReps > 1 ? "\(currReps) Reps" : "\(currReps) Rep") {
                        ForEach(numsArray, id: \.self) { num in
                            Button {
                                currReps = num
                            } label: {
                                Text("\(num)")
                            }
                        }
                    }
                    .foregroundColor(Color("tint_blue"))
                    .padding()

                    Spacer()
                    
                    Menu("\(currWeight) lbs") {
                        ForEach(numsArray, id: \.self) { num in
                            Button {
                                currWeight = num
                            } label: {
                                Text("\(num)")
                            }
                        }
                    }
                    .foregroundColor(Color("tint_blue"))
                    .padding()

                    Spacer()

                    Button {
                        withAnimation {
                            if selectedExercise != nil {
                                let newStrengthExercise = StrengthExerciseData(exerciseData: selectedExercise!, sets: currSets, reps: currReps, weight: currWeight)
                                strengthExerciseList.insert(newStrengthExercise, at: 0)
                            }
                            selectedExercise = nil
                            currSets = 1
                            currReps = 1
                            currWeight = 0
                        }
                    } label: {
                        Text("+")
                    }
                    .fontWeight(.medium)

                    Spacer()
                }
            }
            .padding(.horizontal)
        }
    
    private var selectedExercises: some View {
        VStack(spacing: 0) {
                Text("Selected Workouts")
                    .font(.title3)
                    .foregroundColor(Color("tint_blue"))
                    .padding(.horizontal)
                    .padding(.bottom, 0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if strengthExerciseList.isEmpty {
                    Text("No exercises selected yet.")
                        .foregroundColor(.gray)
                        .padding()
                    
                    Spacer()
                } else {
                    List(strengthExerciseList) { exercise in
                        StrengthExerciseCard(exercise: exercise)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .swipeActions {
                                // delete
                                Button {
                                    // delete
                                    if let index = strengthExerciseList.firstIndex(where: { $0.id == exercise.id }) {
                                            strengthExerciseList.remove(at: index)
                                        }
                                } label: {
                                    Image(systemName: "trash")
                                }
                                
                                // edit
                                Button {
                                    // edit
                                    if let index = strengthExerciseList.firstIndex(where: { $0.id == exercise.id }) {
                                            strengthExerciseList.remove(at: index)
                                        }
                                    selectedExercise = exercise.exerciseData
                                    currSets = exercise.sets
                                    currReps = exercise.reps
                                    currWeight = exercise.weight
                                } label: {
                                    Image(systemName: "pencil")
                                }
                            }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .padding(.top, -8)
                }
            }
        }
}

#Preview {
    WorkoutCreationView()
}

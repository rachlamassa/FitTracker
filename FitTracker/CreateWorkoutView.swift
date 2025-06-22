//
//  CreateWorkoutView.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/10/25.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    
    private let numsArray = Array(1...100)
    @State private var numSets: Int = 1
    @State private var numReps: Int = 1
    @State private var numWeight: Int = 2

    @State private var showSelectExercise: Bool = false
    
    @State private var strengthExercises: [StrengthExercise] = []
    
    @State private var selectedExercise: ExerciseDetails? = nil
        
    @StateObject private var viewModel = BrowseViewModel()
    
    @State private var workoutName: String = ""
    
    @State private var workout: Workout = Workout(name: "Push", type: .strength) // to accomodate hit and strength
    
    // dummy data
    @State private var workouts: [Workouts] = [
            Workouts(name: "Push Workout"),
            Workouts(name: "Pull Workout"),
            Workouts(name: "Legs"),
            Workouts(name: "HIIT"),
            Workouts(name: "Stretching")
        ]
    
    @State private var showDelete: Bool = false
    
    var body: some View {
        VStack (spacing: 20){
            headerSection
            workoutNameForm
            addExercise
                .padding(.horizontal)
            selectedExercises
        }
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $showSelectExercise) {
            ExerciseSelectionView(selectedExercise: $selectedExercise, showSelectExercise: $showSelectExercise)
        }
//        .onChange(of: selectedExercise) {
//            if let newExercise = selectedExercise {
//                let newStrengthExercise = StrengthExercise(
//                    exercise: newExercise,
//                    sets: numSets,
//                    reps: numReps,
//                    weight: numWeight
//                )
//                strengthExercises.insert(newStrengthExercise, at: 0)
//            }
//        }
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
                .padding(.leading, 10)
                .frame(height: 45)
                .background(Color(.white))
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
                .background(.black)
                .cornerRadius(20)
        }
    }
    
    private var exerciseInputSection: some View {
        VStack(spacing: 10) {
            ExerciseCard(context: .create, createCardData: selectedExercise)
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
                        if let newExercise = selectedExercise {
                            let newStrengthExercise = StrengthExercise(
                                exercise: newExercise,
                                sets: numSets,
                                reps: numReps,
                                weight: numWeight
                            )
                            strengthExercises.insert(newStrengthExercise, at: 0)
                        }
                        selectedExercise = nil
                        numSets = 1
                        numReps = 1
                    }
                } label: {
                    Text("+")
                }
                .fontWeight(.medium)

                Spacer()
            }
        }
    }
    
    private var selectedExercises: some View {
        VStack(alignment: .leading) {
            Text("Selected Workouts")
                .font(.headline)
                .padding(.horizontal)

            ScrollView {
                LazyVStack(spacing: 25) {
                    ForEach(strengthExercises) { strengthExercise in
                        StrengthWorkoutCard(strengthExerciseData: strengthExercise)
                            .font(.body)
                            .padding(.horizontal)
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    }

                    if strengthExercises.isEmpty {
                        Text("No exercises selected yet.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .padding(.top)
            }
        }
    }
}

// TODO: button functionality
struct StrengthWorkoutCard: View {
    var strengthExerciseData: StrengthExercise
    @State private var isMoved: Bool = false
    var body: some View {
        HStack (spacing: 20) {
            if let url = strengthExerciseData.exercise?.gifUrl {
                AsyncImage(url: URL(string: url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 36, height: 36)

                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)

                    case .failure:
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)

                    @unknown default:
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)
                    }
                }
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(strengthExerciseData.exercise?.name ?? "data not found")
                    .font(.system(size: 20, weight: .medium))
                Text("\(strengthExerciseData.sets) Sets x \(strengthExerciseData.reps) Reps")
            }

            Spacer()
            
            if isMoved {
                HStack (spacing: 10){
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color(.blue))
                            
                            Image(systemName: "pencil")
                                .foregroundStyle(Color(.white))
                        }
                    }
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color(.red))
                            
                            Image(systemName: "trash")
                                .foregroundStyle(Color(.white))
                        }
                    }
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                Button {
                    withAnimation() {
                        isMoved.toggle()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
        .onTapGesture {
            withAnimation() {
                isMoved = false
            }
        }
        
    }
        
}



#Preview {
    CreateWorkoutView()
}

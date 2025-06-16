//
//  BrowseView.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/9/25.
//

import SwiftUI

struct Workouts: Identifiable {
    let id = UUID()
    let name: String
}

struct BrowseView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = BrowseViewModel()
    @State private var search: String = ""
    @State private var browseType: String = "Exercises"
        
    @State private var workouts: [Workouts] = [
        Workouts(name: "Push Workout"),
        Workouts(name: "Pull Workout"),
        Workouts(name: "Legs"),
        Workouts(name: "HIIT"),
        Workouts(name: "Stretching")
    ]
    
    var body: some View {
        VStack {
            headerSection
            searchBar
            browseList
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                await viewModel.fetchExercises()
            }
        }
        
    }
    
    // TODO: view function for header
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
                Text("Browse \(browseType)")
                Button {
                    if browseType == "Exercises" {
                        browseType = "Workouts"
                    } else {
                        browseType = "Exercises"
                    }
                } label: {
                    Image(systemName: "shuffle")
                }
            }
            .font(.system(size: 20))
        }
        .padding()
        .fontWeight(.medium)
        .foregroundColor(.black)
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)

            TextField(
                "Search exercises...",
                text: $search
            )
            .foregroundColor(.primary)
            .padding(.vertical, 10)
        }
        .background(Color(.systemGray6)) // Matches native search bar
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
    // TODO: view var for list of exercises/ workouts/ routines
    private var browseList: some View {
        List {
            if browseType == "Exercises" {
                ForEach(viewModel.exercises) { exercise in
                    ExerciseCard(context: .browse, browseCardData: exercise)
                        .id(exercise.id) // Optional but helps
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .task {
                                    await viewModel.fetchNextPageIfNeeded(currentItem: exercise)
                                }
                    
                }
                
            } else if browseType == "Workouts" {
                ForEach(workouts) { workout in
                    WorkoutCard(context: .browse)
                        .id(workout.id) // Optional but helps
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
            }
//            .onMove { indices, newOffset in
//                workouts.move(fromOffsets: indices, toOffset: newOffset)
//            }
        }
        .listStyle(.plain)
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: [.bottom])
    }
    
    func deleteWorkout(_ workout: Workout) {
        if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts.remove(at: index)
        }
    }
    
}

#Preview {
    BrowseView()
}

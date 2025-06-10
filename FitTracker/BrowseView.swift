//
//  BrowseView.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/9/25.
//

import SwiftUI

struct Workout: Identifiable {
    let id = UUID()
    let name: String
}

struct BrowseView: View {
    @Environment(\.dismiss) var dismiss
    @State private var search: String = ""
    @State private var browseType: String = "Exercises"
    
    
    @State private var workouts: [Workout] = [
        Workout(name: "Push Workout"),
        Workout(name: "Pull Workout"),
        Workout(name: "Legs"),
        Workout(name: "HIIT"),
        Workout(name: "Stretching")
    ]
    
    var body: some View {
        VStack {
            headerSection
            searchBar
            browseList
        }
        .navigationBarBackButtonHidden(true)
        
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
    
    // TODO: private var search bar
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)
            if browseType == "Exercises" {
                TextField(
                    "Search exercises...",
                    text: $search,
                    prompt: Text("Search exercises...")
                )
                .padding(.vertical, 10)
                .background(Color.white)
            } else {
                TextField(
                    "Search workouts...",
                    text: $search,
                    prompt: Text("Search workouts...")
                )
                .padding(.vertical, 10)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .font(.system(size: 16))
        .fontWeight(.medium)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
    // TODO: view var for list of exercises/ workouts/ routines
    private var browseList: some View {
        List {
            if browseType == "Exercises" {
                ForEach(workouts) { workout in
                    ExerciseCard(context: .browse)
                        .id(workout.id) // Optional but helps
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
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
        .environment(\.editMode, .constant(.active)) // shows drag handles
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

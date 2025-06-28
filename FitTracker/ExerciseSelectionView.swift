//
//  ExerciseSelectionView.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/21/25.
//

import SwiftUI

struct ExerciseSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ExerciseViewModel()
    @State private var search: String = ""
    @Binding var showSelectExercise: Bool
    @Binding var selectedExercise: Exercise?
    
    
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
        Text("Browse Exercises")
        .font(.system(size: 20))
        .padding()
        .fontWeight(.medium)
        .foregroundColor(Color("tint_blue"))
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
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
    // TODO: view var for list of exercises/ workouts/ routines
    private var browseList: some View {
        Group {
            List(viewModel.exercises) { exercise in
                Button {
                    selectedExercise = exercise
                    showSelectExercise = false
                } label: {
                    ExerciseCard(exercise: exercise)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}



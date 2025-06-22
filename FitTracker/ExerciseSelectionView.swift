//
//  ExerciseSelectionView.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/21/25.
//

import SwiftUI

struct ExerciseSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedExercise: ExerciseDetails?
    @Binding var showSelectExercise: Bool

    @StateObject private var viewModel = BrowseViewModel()
    @State private var search: String = ""

    var body: some View {
        VStack {
            header
            searchBar
            exerciseList
        }
        .onAppear {
            Task {
                await viewModel.fetchExercises()
            }
        }
        .background(Color(.systemGroupedBackground))
    }

    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
            .font(.system(size: 16))

            Spacer()

            Text("Select Exercise")
                .font(.system(size: 20))
                .fontWeight(.medium)

            Spacer()
        }
        .padding()
        .foregroundColor(.black)
        .background(Color.white)
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)

            TextField("Search exercises...", text: $search)
                .foregroundColor(.primary)
                .padding(.vertical, 10)
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    private var exerciseList: some View {
        List {
            ForEach(viewModel.exercises.filter {
                search.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(search)
            }) { exercise in
                Button {
                    selectedExercise = exercise
                    showSelectExercise.toggle()
                } label: {
                    ExerciseCard(context: .browse, browseCardData: exercise)
                }
                .buttonStyle(.plain)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .task {
                    await viewModel.fetchNextPageIfNeeded(currentItem: exercise)
                }
            }
        }
        .listStyle(.plain)
        .ignoresSafeArea(edges: .bottom)
    }
}

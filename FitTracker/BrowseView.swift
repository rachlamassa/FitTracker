//
//  BrowseView.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/9/25.
//

import SwiftUI

struct Workouts: Identifiable, Equatable {
    let id = UUID()
    let name: String
}

enum BrowseType {
    case exercises, workouts
    
    func typeStrings() -> String{
        switch self {
            case.exercises: return "Exercises"
            case.workouts: return "Workouts"
        }
    }
}

struct BrowseView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = BrowseViewModel()
    @State private var search: String = ""
    @State private var browseType: BrowseType = .exercises
        
    @State private var workouts: [Workouts] = []
    
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
                Text("Browse \(browseType.typeStrings())")
                Button(action: {
                    browseType = (browseType == .exercises) ? .workouts : .exercises
                }, label: {
                    Image(systemName: "shuffle")
                })

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
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
    // TODO: view var for list of exercises/ workouts/ routines
    private var browseList: some View {
        Group {
            if browseType == .exercises {
                List(viewModel.exercises) { exercise in
                    ExerciseCard(exercise: exercise)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .task {
                            await viewModel.fetchNextPageIfNeeded(currentItem: exercise)
                        }
                }
            } else {
                if workouts.isEmpty {                        VStack {
                        Text("No workouts")
                        .padding()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGroupedBackground))
                    
                } else {
                    List {
                        Text("workout cards")
                    }
                }
                
            }
        }
    }
    
}

#Preview {
    BrowseView()
}

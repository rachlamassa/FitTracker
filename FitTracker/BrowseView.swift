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
    @StateObject var viewModel = ExerciseViewModel()
    @State private var search: String = ""
    @State private var browseType: BrowseType = .exercises
        
    @State private var workouts: [Workouts] = []
    
    var body: some View {
        VStack(spacing: 0) {
            headerSectionBrowse
                .padding(.bottom)
            searchBar
            browseList
        }
        .background(Color(.systemGray6))
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                await viewModel.fetchExercises()
            }
        }
        
    }
    
    private var headerSectionBrowse: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                        Image(systemName: "chevron.left")
                }
                Spacer()
                Button(action: {
                    browseType = (browseType == .exercises) ? .workouts : .exercises
                }, label: {
                    Image(systemName: "shuffle")
                })
            }
            Text("Browse \(browseType.typeStrings())")
                .font(.title)
        }
        .padding()
        .foregroundColor(Color("tint_blue"))
    }
    
    // TODO: functionality
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)

            TextField(
                "Search \(browseType.typeStrings())",
                text: $search
            )
            .padding(.vertical, 10)
        }
        .foregroundColor(.gray)
        .background(Color(.white).opacity(0.45)) // Matches native search bar
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.bottom, 16)
    }
    
    // TODO: view var for list of exercises/ workouts/ routines
    private var browseList: some View {
        Group {
            if browseType == .exercises {
                List(viewModel.exercises) { exercise in
                    ExerciseCard(exercise: exercise)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .padding(.top, -8)
            } else {
                if workouts.isEmpty {
                    VStack {
                        Text("No workouts")
                        .padding()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    
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

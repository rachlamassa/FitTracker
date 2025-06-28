//
//  HomeView.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/8/25.
//

// colors: ui black, ui accent gray

import SwiftUI

struct HomeView: View {
    @State var notifications: Bool = true
    @State private var workouts: [Workout] = [Workout(name: "Push", exercises: [])]
    var body: some View {
        NavigationView {
                
                VStack(spacing: 24) {
                    greeting(message: "Good Morning!") // TODO: time dependent
                    StreakCard()
                        .padding([.horizontal, .bottom])
                    todaysWorkouts
                    Spacer()
                    navigationTabBar()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .padding(.vertical)
                //                }
                .background(Color(.systemGray6))
                .ignoresSafeArea(edges: [.bottom])
            
        }
    }
    
    
    
    private func greeting(message: String) -> some View {
        // TODO: time dependent messages
        VStack(alignment: .leading, spacing: 15) {
            Text(message)
                .font(.title)
            Text("Ready to get fit?")
                .font(.title2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var todaysWorkouts: some View {
        // TODO: title, workout card
        VStack (alignment: .leading, spacing: 0) {
            Text("Today's Workouts")    // TODO: based on how many
                .font(.title3)
                .padding(.leading)
            // workout card
            List (workouts) { workout in
                StrengthWorkoutCard(workout: workout)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .padding(.top, -8)
        }
    }
    
    
}

struct navigationTabBar: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .frame(width: 44, height: 44)
            Image(systemName: "play")
                .frame(width: 44, height: 44)
            Image(systemName: "plus")
                .frame(width: 44, height: 44)
        }
        .foregroundColor(.gray)
        .background(Color(.white).opacity(0.45))
        .cornerRadius(15)
        .padding(.leading)
    }
}

struct StreakCard: View {
    var body: some View {
        // TODO: heading text, # days/ months/ years, fire (lit if streak)
        
        HStack {
            VStack(alignment: .leading) {
                Text("Current Streak")
                    .font(.headline)
                Text("7 days")
                    .font(.title)
            }
            Spacer()
            Image(systemName: "flame")
                .font(.system(size: 44))
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 75)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .cornerRadius(15)
    }
}

#Preview {
    HomeView()
}

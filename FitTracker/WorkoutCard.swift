//
//  WorkoutCard.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/9/25.
//

import SwiftUI

struct WorkoutCard: View {
    // TODO: make struct || WORKOUT, NOT EXERCISES
    var context: WorkoutCardContext
    // var workout: Workout
    var body: some View {
        if context == .home {
            homeCardStyle
        } else if context == .browse {
            browseCardStyle
        } else {
            createCardStyle
        }
    }
    
    private var homeCardStyle: some View {
        VStack {
            HStack {
                Image(systemName: "dumbbell.fill")
                    .font(.system(size: 36))
                VStack (alignment: .leading) {
                    Text("Push")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    Text("45 Minutes | 12 exercises")
                        .font(.system(size: 16))
                }
                Spacer()
            }
            Button {
                // TODO: functionality
            } label: {
                Text("Start Workout")
                    .fontWeight(.medium)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.black)
                    .cornerRadius(20)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .cornerRadius(15)
    }
    
    private var browseCardStyle: some View {
            HStack {
                Image(systemName: "dumbbell.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
                VStack (alignment: .leading) {
                    Text("Push")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    Text("45 Minutes | 12 exercises")
                        .font(.system(size: 16))
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(15)
    }
    
    private var createCardStyle: some View {
            HStack {
                // drag
                Image(systemName: "dumbbell.fill")
                    .font(.system(size: 36))
                VStack (alignment: .leading) {
                    Text("Push")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    Text("45 Minutes | 12 exercises")
                        .font(.system(size: 16))
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(15)
    }
}

enum WorkoutCardContext {
    case home
    case browse
    case create // TODO: later
}

#Preview {
    WorkoutCard(context: .home)
}

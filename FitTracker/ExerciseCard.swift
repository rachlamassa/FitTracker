//
//  ExerciseCard.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/10/25.
//

import SwiftUI

struct ExerciseCard: View {
    // TODO: make struct || WORKOUT, NOT EXERCISES
    var context: ExerciseCardContext
    // var workout: Workout
    var body: some View {
        if context == .browse {
            browseCardStyle
        } else {
            createCardStyle
        }
    }
    
    private var browseCardStyle: some View {
            HStack {
                Image(systemName: "square.fill")
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
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 1)
            )
            .cornerRadius(15)
    }
    
    private var createCardStyle: some View {
            HStack {
                // drag
                Image(systemName: "chevron.up.chevron.down")
                    .padding(.trailing, 8)
                Image(systemName: "square.fill")
                    .font(.system(size: 36))
                VStack (alignment: .leading) {
                    Text("Push-ups")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    Text("3 x 10")
                        .font(.system(size: 16))
                }
                Spacer()
                Button {
                    // delete button
                } label: {
                    Image(systemName: "minus.square.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 1)
            )
            .cornerRadius(15)
    }
}

enum ExerciseCardContext {
    case browse
    case create // TODO: later
}

#Preview {
    ExerciseCard(context: .create)
}

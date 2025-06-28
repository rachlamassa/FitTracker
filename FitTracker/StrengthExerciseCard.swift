//
//  StrengthExerciseCard.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/27/25.
//

import SwiftUI

struct StrengthExerciseCard: View {
    var exercise: StrengthExerciseData
    var body: some View {
        HStack (spacing: 10){
            AsyncImage(url: URL(string: exercise.exerciseData.gifUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 44, height: 44)

                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)

                case .failure:
                    Text("Image Not Found")
                        .frame(width: 44, height: 44)

                @unknown default:
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                }
            }
            .padding()
            VStack (alignment: .leading, spacing: 5){
                Text(exercise.exerciseData.name)
                    .foregroundColor(Color("tint_blue"))
                    .fontWeight(.semibold)
                HStack {
                    Text(exercise.sets > 1 ? "\(exercise.sets) Sets" : "\(exercise.sets) Set")
                    Text(exercise.reps > 1 ? "\(exercise.reps) Reps" : "\(exercise.reps) Rep")
                }
                .foregroundColor(Color("ui_gray"))

                
            }
            .padding(.trailing)
            Spacer()
            Text(exercise.weight == 0 ? "" : "\(exercise.weight) lbs")
                .foregroundColor(Color("ui_gray"))
                .padding(.trailing)
        }
        
        .padding(.vertical, 8)

        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(15)

        
    }
}

//#Preview {
//    StrengthExerciseCard()
//}

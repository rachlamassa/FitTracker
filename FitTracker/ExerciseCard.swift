//
//  ExerciseCard.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/10/25.
//

import SwiftUI

struct ExerciseCard: View {
    var exercise: ExerciseDetails
    var body: some View {
        HStack (spacing: 10){
            AsyncImage(url: URL(string: exercise.gifUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 36, height: 36)

                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 36)

                case .failure:
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 36)

                @unknown default:
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 36)
                }
            }
            .padding()
            VStack (alignment: .leading, spacing: 5){
                Text(exercise.name)
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
                Text(exercise.bodyParts.joined(separator: ", "))
                    .padding(5)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                
            }
        }

        .padding(.vertical, 8)

        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(15)

        
    }
}

//#Preview {
//    ExerciseCard()
//}

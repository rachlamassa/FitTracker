//
//  ExerciseCard.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/10/25.
//

import SwiftUI

struct ExerciseCard: View {
    var exercise: Exercise
    var body: some View {
        HStack (spacing: 10){
            AsyncImage(url: URL(string: exercise.gifUrl)) { phase in
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
                Text(exercise.name)
                    .foregroundColor(Color("tint_blue"))
                    .fontWeight(.semibold)
                Text(exercise.bodyPart)
                    .foregroundColor(Color("ui_gray"))
                    .padding(5)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                
            }
            .padding(.trailing)
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

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
    var browseCardData: ExerciseDetails?
    var createCardData: ExerciseDetails?    // TODO: make exercise class (when put in workout)
    // var workout: Workout
    var body: some View {
        if context == .browse {
            browseCardStyle
        } else {
            createCardStyle
        }
    }
    
    // if browse card data exists, display name, pic, target muscles
    private var browseCardStyle: some View {
        HStack (spacing: 20) {
            if let url = browseCardData?.gifUrl {
                let _ = print("Image URL: \(url)")
                AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/June_odd-eyed-cat.jpg/440px-June_odd-eyed-cat.jpg")) { phase in
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
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(browseCardData?.name.capitalized ?? "data not found")
                    .font(.system(size: 18, weight: .medium))
                HStack {
                    ForEach(browseCardData?.targetMuscles ?? ["data not found"], id: \.self) { bodyPart in
                        Text(bodyPart.capitalized)
                            .font(.system(size: 14))
                            .padding(5)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
    }
    
    // if create card exists, display name, pic, sets/ reps
    private var createCardStyle: some View {
        HStack (spacing: 20) {
            if let url = createCardData?.gifUrl {
                AsyncImage(url: URL(string: url)) { phase in
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
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(createCardData?.name ?? "data not found")
                    .font(.system(size: 20, weight: .medium))
                Text("sets x reps")
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
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

import Foundation

struct ExerciseAPIResponse: Decodable {
    let success: Bool
    let data: ExercisePage
}

struct ExercisePage: Decodable {
    let previousPage: String?
    let nextPage: String?
    let totalPages: Int
    let totalExercises: Int
    let currentPage: Int
    let exercises: [ExerciseDetails]
}

struct ExerciseDetails: Identifiable, Decodable {
    var id: String { exerciseId }
    let exerciseId: String
    let name: String
    let gifUrl: String
    let targetMuscles: [String]
    let bodyParts: [String]
    let equipments: [String]
    let secondaryMuscles: [String]
    let instructions: [String]
}

struct Exercise: Identifiable, Decodable {
    var id = UUID()
    var exerciseDetails: ExerciseDetails
}

@MainActor
class BrowseViewModel: ObservableObject {
    @Published var exercises: [ExerciseDetails] = []
    @Published var isLoading = false
    private var nextPageURL: URL? = URL(string: "https://exercisedb-api.vercel.app/api/v1/exercises?offset=10&limit=10")

    func fetchExercises() async {
        guard let url = URL(string: "https://exercisedb-api.vercel.app/api/v1/exercises") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // Optional: print JSON
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Loaded:\n\(jsonString.prefix(300))...")
            }

            let decoded = try JSONDecoder().decode(ExerciseAPIResponse.self, from: data)
            exercises = decoded.data.exercises
            print("✅ Loaded \(exercises.count) exercises")
        } catch {
            print("❌ Fetching error:", error.localizedDescription)
        }
    }
    
    

    func fetchNextPageIfNeeded(currentItem: ExerciseDetails?) async {
        guard let currentItem = currentItem else { return }
        guard let lastItem = exercises.last else { return }
        
        // Only trigger if we're near the end
        if currentItem.exerciseId == lastItem.exerciseId {
            await fetchMoreExercises()
        }
    }

    func fetchMoreExercises() async {
        guard !isLoading else { return }
        guard let url = nextPageURL else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(ExerciseAPIResponse.self, from: data)
            exercises += decoded.data.exercises
            nextPageURL = URL(string: decoded.data.nextPage ?? "")
        } catch {
            print("❌ Pagination error:", error.localizedDescription)
        }
    }
    
}

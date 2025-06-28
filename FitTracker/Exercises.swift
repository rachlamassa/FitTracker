import Foundation

struct Exercise: Identifiable, Decodable, Equatable {
    let bodyPart: String
    let equipment: String
    let gifUrl: String
    let id: String
    let name: String
    let target: String
    let secondaryMuscles: [String]
    let instructions: [String]
    let description: String
    let difficulty: String
    let category: String
    
    var displayName: String {
        name.capitalized
    }
}

@MainActor
class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var isLoading = false

    private let apiKey = "d57c8cd4b4mshcd3351f89f42301p1f6e30jsne88d8c92a6bb"
    private let baseURL = URL(string: "https://exercisedb.p.rapidapi.com/exercises?limit=0&offset=0")!

    func fetchExercises() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }

        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("exercisedb.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let raw = String(data: data, encoding: .utf8) {
                print("💾 Raw JSON:\n\(raw.prefix(300))")
            }
            let decoded = try JSONDecoder().decode([Exercise].self, from: data)
            self.exercises = decoded
            print("✅ Loaded \(decoded.count) exercises")
        } catch {
            print("❌ Error fetching exercises:", error.localizedDescription)
        }
    }
}

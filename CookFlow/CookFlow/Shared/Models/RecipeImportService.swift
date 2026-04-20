import Foundation

struct ExtractedRecipeDTO: Codable {
    let title: String
    let prepTimeMinutes: Int?
    let cookTimeMinutes: Int?
    let totalTimeMinutes: Int?
    let servings: String?
    let ingredients: [String]
    let instructions: [String]
    let sourceURL: String
}

enum RecipeImportServiceError: LocalizedError {
    case invalidResponse
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "We could not read the recipe response."
        case .serverError(let code):
            return "The server returned an error (\(code))."
        }
    }
}

final class RecipeImportService {
    private let baseURL: URL

    init(baseURL: URL = URL(string: "https://api.cookflow.app")!) {
        self.baseURL = baseURL
    }

    func importRecipe(from url: URL) async throws -> ExtractedRecipeDTO {
#if DEBUG
        if RecipeImportService.useStubResponse {
            return ExtractedRecipeDTO(
                title: "Tuscan Garlic Chicken",
                prepTimeMinutes: 15,
                cookTimeMinutes: 25,
                totalTimeMinutes: 40,
                servings: "4",
                ingredients: [
                    "2 tbsp olive oil",
                    "4 chicken thighs",
                    "3 cloves garlic, minced",
                    "1 cup cherry tomatoes",
                    "1/2 cup cream",
                    "1 tsp Italian seasoning"
                ],
                instructions: [
                    "Season the chicken and sear in olive oil.",
                    "Add garlic and tomatoes; cook until fragrant.",
                    "Stir in cream and seasoning, then simmer.",
                    "Serve warm."
                ],
                sourceURL: url.absoluteString
            )
        }
#endif

        var request = URLRequest(url: baseURL.appendingPathComponent("recipe/extract"))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(["url": url.absoluteString])

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RecipeImportServiceError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw RecipeImportServiceError.serverError(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(ExtractedRecipeDTO.self, from: data)
        } catch {
            throw RecipeImportServiceError.invalidResponse
        }
    }
}

#if DEBUG
extension RecipeImportService {
    static let useStubResponse = true
}
#endif

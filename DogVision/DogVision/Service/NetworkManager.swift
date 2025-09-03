import Foundation
import UIKit

@MainActor
class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    
    // Your FastAPI server URL - Update this with your actual server URL
    private let baseURL = "http://localhost:8000"  // Change to your server URL
    
    private init() {}
    
    // MARK: - Dog Breed Prediction
    func predictDogBreed(image: UIImage) async throws -> PredictionResponse {
        guard let url = URL(string: "\(baseURL)/predict") else {
            throw NetworkError.invalidURL
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw NetworkError.imageProcessingFailed
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = createMultipartBody(imageData: imageData, boundary: boundary)
        request.httpBody = body
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let predictionResponse = try JSONDecoder().decode(PredictionResponse.self, from: data)
            return predictionResponse
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    // MARK: - Gemini API Call for Breed Info
    func getBreedInfo(breedName: String) async throws -> String {
        let prompt = "Tell me about the \(breedName.replacingOccurrences(of: "_", with: " ")) dog breed. Include characteristics, temperament, and interesting facts in 2-3 paragraphs."
        
        // Replace with your Gemini API key
        let apiKey = "YOUR_GEMINI_API_KEY"
        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\(apiKey)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": prompt]
                    ]
                ]
            ]
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let candidates = json["candidates"] as? [[String: Any]],
              let firstCandidate = candidates.first,
              let content = firstCandidate["content"] as? [String: Any],
              let parts = content["parts"] as? [[String: Any]],
              let firstPart = parts.first,
              let text = firstPart["text"] as? String else {
            throw NetworkError.invalidResponse
        }
        
        return text
    }
    
    // MARK: - Helper Methods
    private func createMultipartBody(imageData: Data, boundary: String) -> Data {
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}

// MARK: - Network Errors
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case imageProcessingFailed
    case invalidResponse
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .imageProcessingFailed:
            return "Failed to process image"
        case .invalidResponse:
            return "Invalid response format"
        case .decodingFailed:
            return "Failed to decode response"
        }
    }
}

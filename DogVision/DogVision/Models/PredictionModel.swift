import Foundation


struct PredictionResponse : Codable{
    
        let status: String
        let predictedBreed: String
        let confidence: Double
        let message: String
        
        enum CodingKeys: String, CodingKey {
            case status
            case predictedBreed = "predicted_breed"
            case confidence
            case message
        }
}


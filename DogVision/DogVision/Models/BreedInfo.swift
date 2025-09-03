import Foundation

struct BreedInfo {
    let breedName: String
    let confidence: Double
    let information: String
    let isLoading: Bool
    
    static let empty = BreedInfo(
        breedName: "",
        confidence: 0.0,
        information: "",
        isLoading: false
    )
}


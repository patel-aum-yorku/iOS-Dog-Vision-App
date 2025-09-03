import Foundation
import UIKit
import SwiftUI

@MainActor
class DogClassifierViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var breedInfo: BreedInfo = BreedInfo.empty
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showingImagePicker = false
    @Published var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Image Selection
    func selectImage(from sourceType: UIImagePickerController.SourceType) {
        imagePickerSourceType = sourceType
        showingImagePicker = true
    }
    
    func imageSelected(_ image: UIImage) {
        selectedImage = image
        // Reset previous results
        breedInfo = BreedInfo.empty
        errorMessage = nil
    }
    
    // MARK: - Prediction
    func predictBreed() {
        guard let image = selectedImage else {
            errorMessage = "Please select an image first"
            return
        }
        
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                // Step 1: Get breed prediction
                let prediction = try await networkManager.predictDogBreed(image: image)
                
                // Step 2: Get breed information
                let information = try await networkManager.getBreedInfo(breedName: prediction.predictedBreed)
                
                // Update UI
                breedInfo = BreedInfo(
                    breedName: formatBreedName(prediction.predictedBreed),
                    confidence: prediction.confidence,
                    information: information,
                    isLoading: false
                )
                
            } catch {
                errorMessage = error.localizedDescription
                breedInfo = BreedInfo.empty
            }
            
            isLoading = false
        }
    }
    
    // MARK: - Helper Methods
    private func formatBreedName(_ breedName: String) -> String {
        return breedName.replacingOccurrences(of: "_", with: " ").capitalized
    }
    
    func resetApp() {
        selectedImage = nil
        breedInfo = BreedInfo.empty
        errorMessage = nil
        isLoading = false
    }
}

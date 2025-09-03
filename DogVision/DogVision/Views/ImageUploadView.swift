import SwiftUI

struct ImageUploadView: View {
    @EnvironmentObject var viewModel: DogClassifierViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Dog Breed Classifier")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            // Image Display
            imageDisplaySection
            
            // Action Buttons
            actionButtonsSection
            
            // Error Message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $viewModel.showingImagePicker) {
            ImagePicker(
                selectedImage: Binding(
                    get: { viewModel.selectedImage },
                    set: { image in
                        if let image = image {
                            viewModel.imageSelected(image)
                        }
                    }
                ),
                sourceType: viewModel.imagePickerSourceType
            )
        }
        .overlay(
            // Loading Overlay
            Group {
                if viewModel.isLoading {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    VStack {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Analyzing your dog...")
                            .padding(.top)
                            .foregroundColor(.white)
                    }
                }
            }
        )
    }
    
    // MARK: - Image Display Section
    private var imageDisplaySection: some View {
        Group {
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 300)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 300)
                    .cornerRadius(12)
                    .overlay(
                        VStack {
                            Image(systemName: "photo")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("Select an image")
                                .foregroundColor(.gray)
                                .padding(.top)
                        }
                    )
            }
        }
    }
    
    // MARK: - Action Buttons Section
    private var actionButtonsSection: some View {
        VStack(spacing: 15) {
            HStack(spacing: 15) {
                // Gallery Button
                Button(action: {
                    viewModel.selectImage(from: .photoLibrary)
                }) {
                    HStack {
                        Image(systemName: "photo.on.rectangle")
                        Text("Gallery")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                // Camera Button
                Button(action: {
                    viewModel.selectImage(from: .camera)
                }) {
                    HStack {
                        Image(systemName: "camera")
                        Text("Camera")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            
            // Predict Button
            Button(action: {
                viewModel.predictBreed()
            }) {
                HStack {
                    Image(systemName: "sparkles")
                    Text("Predict Breed")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.selectedImage == nil ? Color.gray : Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(viewModel.selectedImage == nil || viewModel.isLoading)
        }
    }
}

#Preview {
    ImageUploadView()
        .environmentObject(DogClassifierViewModel())
}

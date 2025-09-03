import SwiftUI

struct BreedInfoView: View {
    @EnvironmentObject var viewModel: DogClassifierViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Back Button
                HStack {
                    Button(action: {
                        viewModel.resetApp()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                    Spacer()
                }
                .padding(.top)
                
                // Dog Image
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 250)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                
                // Breed Information
                VStack(spacing: 15) {
                    // Breed Name
                    Text(viewModel.breedInfo.breedName)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    // Confidence Score
                    Text(String(format: "Confidence: %.1f%%", viewModel.breedInfo.confidence * 100))
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    // Breed Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("About this breed:")
                            .font(.headline)
                            .padding(.top)
                        
                        if viewModel.breedInfo.information.isEmpty && viewModel.isLoading {
                            HStack {
                                ProgressView()
                                    .scaleEffect(0.8)
                                Text("Loading breed information...")
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            Text(viewModel.breedInfo.information)
                                .font(.body)
                                .lineSpacing(4)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
                
                Spacer(minLength: 20)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    BreedInfoView()
        .environmentObject({
            let vm = DogClassifierViewModel()
            vm.breedInfo = BreedInfo(
                breedName: "Golden Retriever",
                confidence: 0.95,
                information: "Golden Retrievers are friendly, intelligent, and devoted dogs. They are among the most popular dog breeds in the United States.",
                isLoading: false
            )
            return vm
        }())
}

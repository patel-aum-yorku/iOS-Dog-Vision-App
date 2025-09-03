import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DogClassifierViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.breedInfo.breedName.isEmpty && !viewModel.isLoading {
                ImageUploadView()
                    .environmentObject(viewModel)
            } else {
                BreedInfoView()
                    .environmentObject(viewModel)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Ensures proper navigation on iPad
    }
}
#Preview {
    ContentView()
}

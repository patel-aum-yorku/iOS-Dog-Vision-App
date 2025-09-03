# 🐕 Dog Vision iOS App

An intelligent iOS application that uses machine learning to identify dog breeds from photos. Built with SwiftUI and MVVM architecture, featuring real-time image classification and detailed breed information.

## 📱 Features

- **Camera & Photo Library Integration** - Take photos or select from gallery
- **Real-time ML Prediction** - Classify dog breeds with confidence scores
- **Detailed Breed Information** - AI-powered breed facts and characteristics
- **Modern SwiftUI UI** - Responsive design with smooth animations
- **MVVM Architecture** - Clean, maintainable code structure
- **Async/Await Networking** - Modern Swift concurrency for API calls

## 🛠 Tech Stack

- **Frontend**: Swift, SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Networking**: URLSession with async/await
- **State Management**: @Published, @StateObject, Environment Objects
- **Backend**: FastAPI (Python)
- **ML Integration**: Custom trained model via REST API
- **AI Services**: Google Gemini API for breed information

## 🏗 Architecture

```
DogBreedClassifier/
├── Models/
│   ├── PredictionModel.swift      # Data models for API responses
│   └── BreedInfo.swift           # Breed information model
├── ViewModels/
│   └── DogClassifierViewModel.swift # Business logic & state management
├── Views/
│   ├── ContentView.swift         # Main navigation view
│   ├── ImageUploadView.swift     # Image selection & upload
│   └── BreedInfoView.swift       # Results display
├── Services/
│   └── NetworkManager.swift     # API communication
└── Utilities/
    └── ImagePicker.swift         # UIKit bridge for image picker
```

## 🚀 Getting Started

### Prerequisites

- Xcode 14.0+
- iOS 15.0+
- Swift 5.5+
- Active internet connection
- FastAPI backend server (see Backend Setup)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/patel-aum-yorku/iOS-Dog-Vision-App.git
   cd dog-breed-classifier-ios
   ```

2. **Open in Xcode**
   ```bash
   open DogBreedClassifier.xcodeproj
   ```

3. **Configure API Keys**
   
   Update `NetworkManager.swift`:
   ```swift
   // Replace with your FastAPI server URL
   private let baseURL = "http://YOUR_SERVER_IP:8000"
   
   // Replace with your Gemini API key
   let apiKey = "YOUR_GEMINI_API_KEY"
   ```

4. **Build and Run**
   - Select target device (iPhone/iPad or Simulator)
   - Press `⌘ + R` or click the Run button

### Backend Setup

The app requires a FastAPI backend server with your ML model:

**🔗 Backend Repository**: [Dog-Vision-AI](https://github.com/patel-aum-yorku/Dog-Vision-AI)  
*Complete ML model training, FastAPI server, and backend implementation*

1. **Clone and Setup Backend**
   ```bash
   # Clone the backend repository
   git clone https://github.com/patel-aum-yorku/Dog-Vision-AI.git
   cd Dog-Vision-AI
   
   # Install dependencies
   pip install -r requirements.txt
   
   # Start the FastAPI server
   uvicorn main:app --host 0.0.0.0 --port 8000 --reload
   ```

2. **FastAPI Server API Structure**
   ```
   POST /predict
   Content-Type: multipart/form-data
   Body: Image file (JPEG/PNG, max 10MB)
   
   Response:
   {
     "status": "success",
     "predicted_breed": "golden_retriever",
     "confidence": 0.9234,
     "message": "Prediction successful"
   }
   ```

### API Keys Setup

1. **Get Gemini API Key**
   - Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Create a new API key
   - Add to `NetworkManager.swift`

2. **Network Configuration**
   - Ensure your device and server are on the same network
   - Use your computer's IP address, not `localhost`

## 📱 Usage

1. **Launch the app** on your iOS device
2. **Select an image** using Camera or Gallery button
3. **Tap "Predict Breed"** to analyze the image
4. **View results** with breed name, confidence score, and detailed information
5. **Tap "Back"** to classify another dog


## 🔒 Permissions

The app requires the following iOS permissions:

- **NSCameraUsageDescription** - Camera access for taking photos
- **NSPhotoLibraryUsageDescription** - Photo library access for selecting images

These are configured in `Info.plist` and will prompt users on first use.

## 🐛 Troubleshooting

### Common Issues
**Camera Not Working**
- Test on physical device (camera unavailable in simulator)
- Check camera permissions in iOS Settings
- Verify `Info.plist` permissions are set

**Gemini API Errors**
- Validate API key is correct
- Check internet connection
- Verify API quota and billing

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author
**Aum Patel**

## 🔗 Related Projects

- **[Dog-Vision-AI Backend](https://github.com/patel-aum-yorku/Dog-Vision-AI)** - Complete ML model training, FastAPI server implementation, and backend services for this iOS app


---

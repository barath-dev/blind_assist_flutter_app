# EchoVision - Blind Assist Mobile Application

## Project Overview
EchoVision is an accessibility-focused mobile application built with Flutter, designed to empower visually impaired users with AI-powered vision assistance and intuitive voice-guided navigation. The app provides essential daily assistance through currency recognition, expiry date detection, and location-based services.

## Key Features

### 1. AI-Powered Currency Recognition
- Real-time camera integration for capturing currency notes
- Google Gemini AI integration for accurate denomination identification
- Text-to-Speech feedback announcing detected currency values
- Optimized image processing with compression for efficient API calls

### 2. Expiry Date Detection
- Computer vision-based expiry date finder for products and medicines
- ML Kit text recognition for extracting date information from product packaging
- Voice-guided results for hands-free operation
- Intelligent parsing and announcement of expiry information

### 3. Accessibility-First Navigation
- Gesture-based interface (tap, double-tap, swipe, long-press)
- Comprehensive Text-to-Speech (TTS) integration for all user interactions
- Speech-to-Text (STT) capabilities for voice commands
- Audio instructions guide users through each screen and feature
- No reliance on visual cues - fully navigable through audio feedback

### 4. Location Services
- GPS integration with real-time location tracking
- Voice-activated map navigation
- Location permission handling with user-friendly prompts
- Maps launcher integration for external navigation apps

## Technical Implementation

### Flutter & Dart
- Built on Flutter SDK 3.2+ for cross-platform compatibility (iOS & Android)
- Clean architecture with separation of concerns (screens, services, resources)
- State management using StatefulWidget pattern
- Lifecycle-aware components for optimal resource management

### AI & Machine Learning Integration
- **Google Gemini API**: Vision AI for currency and expiry date recognition
- **ML Kit Text Recognition**: On-device OCR for text extraction
- Custom image preprocessing and optimization pipeline
- Efficient prompt engineering for accurate AI responses

### Key Dependencies & Services
- **Camera Integration**: High-quality image capture with configurable resolution
- **Firebase**: Backend integration for cloud storage and data persistence
- **Geolocator**: Precise location services with multiple accuracy levels
- **Permission Handler**: Robust runtime permission management
- **TTS/STT Services**: Seamless voice interaction layer
- **Image Compression**: FlutterImageCompress for optimized network usage

### Advanced Features
- Real-time camera preview with optimized performance
- Custom gesture recognizers for intuitive interaction patterns
- Background/foreground state handling for resource optimization
- Error handling with user-friendly voice feedback
- Firebase Storage integration for image uploads

## Development Highlights
- **Accessibility-First Design**: Every feature designed with visually impaired users in mind
- **Performance Optimization**: Camera resource management, image compression, and efficient API calls
- **User Experience**: Voice-guided onboarding and contextual audio assistance
- **Clean Code**: Well-structured codebase with clear separation of UI, business logic, and services
- **Modern Flutter Practices**: Google Fonts, Material Design 3, dark theme support

## Technical Skills Demonstrated
- Flutter/Dart mobile development
- AI/ML integration (Google Gemini, ML Kit)
- Camera and image processing
- Firebase cloud services
- Geolocation and mapping services
- Accessibility implementation
- State management
- Permission handling
- Text-to-Speech/Speech-to-Text integration
- RESTful API integration
- Git version control

## Impact
This application addresses real-world accessibility challenges by providing visually impaired users with essential tools for daily independence, including currency identification for transactions and expiry date checking for food safety.

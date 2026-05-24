# EQi30 - Emotional Intelligence Leadership App

<div align="center">
  <img src="assets/images/launcher icon.png" alt="EQi30 Logo" width="120" height="120">
  
  <p align="center">
    <strong>30 Micro-Abilities for Calmer, Clearer, More Effective Leadership</strong>
  </p>
  
  <p align="center">
    A comprehensive Flutter application designed to enhance emotional intelligence through personalized learning journeys, AI-powered coaching, and evidence-based micro-abilities.
  </p>
</div>

---

## 📱 About EQi30

EQi30 is a mobile application that helps leaders and professionals develop their emotional intelligence through 30 carefully curated micro-abilities. The app provides personalized learning paths, AI-powered coaching, and interactive resources to build essential competencies in self-management, interpersonal skills, decision-making, and more.

### Key Features

- 🎯 **Personalized Learning Journeys** - Custom-tailored paths based on your competency assessment
- 🤖 **AI-Powered Coaching** - Interactive chat with AI coach for guidance and support
- 📊 **Progress Tracking** - Visual analytics and insights into your growth
- 🎓 **Rich Learning Resources** - Videos, audio guides, articles, and interactive exercises
- 🏆 **Competency Assessment** - Identify strengths and areas for development
- ⏰ **Smart Reminders** - Stay on track with customizable notifications
- 🎨 **Beautiful UI/UX** - Intuitive design with smooth animations
- 🌙 **Adaptive Experience** - Personalized content based on your pace and preferences

---

## 🏗️ Architecture & Tech Stack

### Framework & Language
- **Flutter** 3.10.7+
- **Dart** SDK ^3.10.7

### State Management
- **Provider** - Efficient state management across the app

### Navigation
- **go_router** - Declarative routing with deep linking support

### UI & Animations
- **Lottie** - High-quality animations
- **Confetti** - Celebration effects for achievements
- **Google Fonts** - Beautiful typography
- **flutter_svg** - Scalable vector graphics

### Media & Content
- **video_player** - Video learning content
- **audioplayers** - Audio meditation and guides
- **image_picker** - Profile customization

### Storage & Data
- **shared_preferences** - Local data persistence
- **http** - API communication

### Additional Features
- **pinput** - Secure PIN input for authentication
- **intl** - Internationalization and date formatting

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── routes/          # App routing configuration
│   └── theme/           # Theme and styling
├── features/
│   ├── abilities/       # Competency and ability management
│   ├── auth/            # Authentication & splash screen
│   ├── chat/            # AI coach chat interface
│   ├── feedback/        # User feedback system
│   ├── home/            # Main dashboard
│   ├── journey/         # Learning journey management
│   ├── onboarding/      # User onboarding flow
│   ├── profile/         # User profile management
│   ├── progress/        # Progress tracking & analytics
│   ├── resources/       # Learning resources library
│   ├── result/          # Assessment results
│   └── settings/        # App settings & preferences
├── screens/             # Additional screens
└── main.dart            # App entry point

assets/
├── images/              # Image assets
├── icons/               # Icon assets
├── fonts/               # Custom fonts
└── animations/          # Lottie animation files
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.10.7 or higher)
- Dart SDK (3.10.7 or higher)
- Android Studio / VS Code with Flutter extensions
- iOS development: Xcode (for macOS users)
- Android development: Android SDK

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/eqi30.git
   cd eqi30
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate launcher icons** (if needed)
   ```bash
   flutter pub run flutter_launcher_icons
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
- Minimum SDK: 21 (Android 5.0)
- Target SDK: 34
- Gradle: 8.0+
- Kotlin: 1.9.0+

#### iOS
- Minimum iOS version: 12.0
- Xcode: 14.0+
- CocoaPods: Latest version

---

## 🎨 Features Overview

### 1. Onboarding & Assessment
- Interactive onboarding flow
- Comprehensive competency assessment
- AI-powered personalized recommendations
- Custom journey creation

### 2. Learning Journeys
- 30 micro-abilities across 6 core competencies:
  - Self-Management
  - Interpersonal Management
  - Decision Making
  - Executive Function
  - Stress Management
  - Spirit & Energy
- Structured learning paths
- Flexible pacing options
- Progress milestones

### 3. AI Coach
- Real-time chat support
- Personalized guidance
- Context-aware responses
- Learning reinforcement

### 4. Resources Library
- Video tutorials
- Audio meditations
- Articles and guides
- Interactive exercises
- Downloadable materials

### 5. Progress Tracking
- Visual progress indicators
- Competency radar charts
- Achievement badges
- Historical analytics
- Growth insights

### 6. Profile & Settings
- Customizable profile
- Learning preferences
- Notification management
- Security settings
- Subscription management

---

## 🎯 Core Competencies

### 1. Self-Management
Master emotional regulation, self-awareness, and personal accountability.

### 2. Interpersonal Management
Build stronger relationships through empathy, communication, and social awareness.

### 3. Decision Making
Enhance critical thinking, problem-solving, and strategic judgment.

### 4. Executive Function
Improve planning, organization, and goal-directed behavior.

### 5. Stress Management
Develop resilience, coping strategies, and work-life balance.

### 6. Spirit & Energy
Cultivate purpose, motivation, and sustainable energy management.

---

## 🔧 Configuration

### Environment Setup

Create a `.env` file in the root directory (if using environment variables):
```env
API_BASE_URL=your_api_url
API_KEY=your_api_key
```

### Firebase Setup (Optional)

If integrating Firebase:
1. Add `google-services.json` to `android/app/`
2. Add `GoogleService-Info.plist` to `ios/Runner/`
3. Uncomment Firebase dependencies in `pubspec.yaml`

---

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

---

## 📦 Build & Release

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

---

## 🎨 Design System

### Color Palette
- Primary Gradient: `#FFE7DB` → `#DAF8FF`
- Accent Colors:
  - Self-Management: `#43BDC7`
  - Decision Making: `#F1C182`
  - Executive Function: `#3D8C8C`
  - Interpersonal: `#E8A87C`
  - Stress Management: `#B8D4D4`
  - Spirit & Energy: `#F5D5C8`

### Typography
- Primary Font: Google Fonts (Inter)
- Display Font: Days One

### Animations
- Splash Screen: Fade, scale, and slide animations
- Page Transitions: Smooth route transitions
- Micro-interactions: Lottie animations for feedback

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Write tests for new features

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Team

- **Development Team** - Flutter Development
- **Design Team** - UI/UX Design
- **Content Team** - Learning Content Creation
- **Research Team** - Evidence-Based Methodology

---

## 📞 Support

For support, email support@eqi30.com or join our community:

- 📧 Email: support@eqi30.com
- 🌐 Website: [www.eqi30.com](https://www.eqi30.com)
- 💬 Discord: [Join our community](https://discord.gg/eqi30)
- 📱 Twitter: [@eqi30app](https://twitter.com/eqi30app)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All contributors and beta testers
- Research partners in emotional intelligence
- Open-source community

---

## 📊 Project Status

- ✅ Core Features: Complete
- ✅ UI/UX: Complete
- ✅ Animations: Complete
- ✅ Launcher Icons: Complete
- 🚧 Backend Integration: In Progress
- 🚧 Testing: In Progress
- 📅 Release: Coming Soon

---

<div align="center">
  <p>Made with ❤️ by the Mehedi Hasan Mridul</p>
  <p>© 2026 All rights reserved.</p>
</div>

# 🌟 EQi30 - Emotional Intelligence Leadership App

<div align="center">
  <img src="assets/images/launcher icon.png" alt="EQi30 Logo" width="120" height="120" style="border-radius: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
  
  <br />
  
  **30 Micro-Abilities for Calmer, Clearer, More Effective Leadership**
  
  <p>
    A comprehensive Flutter application designed to enhance emotional intelligence through personalized learning journeys, AI-powered coaching, and evidence-based micro-abilities.
  </p>

  <p>
    <img src="https://img.shields.io/badge/Flutter-3.10.7+-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter Version" />
    <img src="https://img.shields.io/badge/Dart-3.10.7+-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart Version" />
    <img src="https://img.shields.io/badge/Status-In%20Progress-F2C94C?style=for-the-badge" alt="Status" />
  </p>
</div>

---

## 📱 About EQi30

EQi30 is a state-of-the-art mobile application that helps leaders and professionals develop their emotional intelligence. It focuses on **30 carefully curated micro-abilities** to foster growth. The app provides personalized learning paths, AI-powered coaching, and interactive resources to build essential competencies in self-management, interpersonal skills, decision-making, and more.

### ✨ Key Features

| Feature | Description |
| :--- | :--- |
| 🎯 **Personalized Journeys** | Custom-tailored paths based on your competency assessment. |
| 🤖 **AI-Powered Coaching** | Interactive chat with an AI coach for guidance and support. |
| 📊 **Progress Tracking** | Visual analytics and insights into your growth over time. |
| 🎓 **Rich Learning Resources** | Videos, audio guides, articles, and interactive exercises. |
| 🏆 **Competency Assessment** | Identify your strengths and pinpoint areas for development. |
| ⏰ **Smart Reminders** | Stay on track with customizable, polite notifications. |
| 🎨 **Beautiful UI/UX** | Intuitive design with smooth animations and transitions. |
| 🌙 **Adaptive Experience** | Personalized content based on your pace and preferences. |

---

## 🏗️ Architecture & Tech Stack

The app is built using modern frameworks and robust libraries to ensure a fluid and maintainable experience.

- **Framework & Language:** Flutter (3.10.7+), Dart (^3.10.7)
- **State Management:** `provider` for efficient and scalable state handling
- **Navigation:** `go_router` for declarative routing and deep linking
- **UI & Animations:** `lottie` (high-quality animations), `confetti` (celebrations), `flutter_svg`, Google Fonts
- **Media & Content:** `video_player`, `audioplayers`, `image_picker`
- **Storage & Data:** `shared_preferences` (local persistence), `http` (API integration)
- **Utilities:** `pinput` (secure PIN), `intl` (internationalization)

---

## 📂 Project Structure

A clean, feature-driven architecture that scales easily.

```text
lib/
├── core/
│   ├── routes/          # App routing configuration (go_router)
│   └── theme/           # Global theme, colors, and styling
├── features/
│   ├── abilities/       # Competency and ability management
│   ├── auth/            # Authentication & splash screen logic
│   ├── chat/            # AI coach chat interface & logic
│   ├── feedback/        # User feedback system
│   ├── home/            # Main dashboard and overview
│   ├── journey/         # Learning journey management
│   ├── onboarding/      # User onboarding and initial setup flow
│   ├── profile/         # User profile and settings
│   ├── progress/        # Progress tracking, charts & analytics
│   ├── resources/       # Learning resources library (video/audio)
│   ├── result/          # Assessment results visualization
│   └── settings/        # App preferences
├── screens/             # Additional shared or standalone screens
├── shared/              # Shared components and utilities
└── main.dart            # Application entry point
```

---

## 🚀 Getting Started

Follow these steps to get a local copy up and running.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.10.7 or higher)
- [Dart SDK](https://dart.dev/get-dart) (3.10.7 or higher)
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS development, macOS only)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/eqi30.git
   cd eqi30
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

*(Optional) Generate launcher icons:*
```bash
flutter pub run flutter_launcher_icons
```

---

## 🎯 Core Competencies

The app's curriculum is divided into 6 core competencies, each focusing on distinct areas of emotional intelligence:

1. 🧠 **Self-Management:** Master emotional regulation, self-awareness, and personal accountability.
2. 🤝 **Interpersonal Management:** Build stronger relationships through empathy and social awareness.
3. ⚖️ **Decision Making:** Enhance critical thinking, problem-solving, and strategic judgment.
4. 📋 **Executive Function:** Improve planning, organization, and goal-directed behavior.
5. 🧘 **Stress Management:** Develop resilience, coping strategies, and work-life balance.
6. ⚡ **Spirit & Energy:** Cultivate purpose, motivation, and sustainable energy management.

---

## 🎨 Design System

Our design philosophy revolves around calmness, clarity, and delight.

- **Primary Gradient:** `#FFE7DB` → `#DAF8FF`
- **Typography:** `Inter` (Primary), `Days One` (Display)
- **Animations:** Smooth Lottie micro-interactions, fade/scale route transitions.

---

## 🧪 Testing & Build

### Testing
- Run Unit Tests: `flutter test`
- Tests with Coverage: `flutter test --coverage`
- Integration Tests: `flutter drive --target=test_driver/app.dart`

### Building for Release
- **Android APK:** `flutter build apk --release`
- **Android App Bundle:** `flutter build appbundle --release`
- **iOS:** `flutter build ios --release`

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License & Team

Distributed under the MIT License. See `LICENSE` for more information.

- **Design & Dev:** Flutter Development & UI/UX Design Teams
- **Content & Research:** Evidence-Based Methodology Teams

<div align="center">
  <br/>
  <p>Made with ❤️ by <strong>Mehedi Hasan Mridul</strong></p>
  <p>© 2026 All rights reserved.</p>
</div>

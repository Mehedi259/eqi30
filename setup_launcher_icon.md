# Launcher Icon Setup Guide

## Steps to Generate Launcher Icons

### 1. Install Dependencies
Run this command to install the flutter_launcher_icons package:
```bash
flutter pub get
```

### 2. Generate Launcher Icons
Run this command to generate all launcher icons for Android, iOS, and Web:
```bash
flutter pub run flutter_launcher_icons
```

This will automatically:
- Generate Android launcher icons in all required sizes (mipmap-hdpi, mdpi, xhdpi, xxhdpi, xxxhdpi)
- Generate iOS launcher icons in all required sizes
- Create adaptive icons for Android (API 26+)
- Generate web icons (if applicable)

### 3. Copy Splash Logo for Native Splash Screen
Copy your launcher icon to the Android drawable folder for the native splash screen:

**For Windows (PowerShell):**
```powershell
Copy-Item "assets/images/launcher icon.png" "android/app/src/main/res/drawable/splash_logo.png"
```

**For Windows (CMD):**
```cmd
copy "assets\images\launcher icon.png" "android\app\src\main\res\drawable\splash_logo.png"
```

**For macOS/Linux:**
```bash
cp "assets/images/launcher icon.png" android/app/src/main/res/drawable/splash_logo.png
```

### 4. Update iOS Launch Screen (Optional)
The iOS LaunchScreen.storyboard is already configured to use "LaunchImage". 
You can either:
- Keep using the existing LaunchImage in Assets.xcassets
- Or update the storyboard to reference your new icon

### 5. Clean and Rebuild
After generating icons, clean and rebuild your app:
```bash
flutter clean
flutter pub get
flutter run
```

## Configuration Details

The launcher icon configuration in `pubspec.yaml`:
- **Source Image**: `assets/images/launcher icon.png`
- **Android**: Generates standard and adaptive icons
- **iOS**: Generates all required icon sizes
- **Adaptive Icon Background**: #FFE7DB (matches your brand gradient)
- **Web**: Generates favicon and PWA icons

## Icon Requirements

For best results, your launcher icon should be:
- **Size**: 1024x1024 pixels (minimum 512x512)
- **Format**: PNG with transparency
- **Design**: Simple, recognizable, works at small sizes
- **Safe Area**: Keep important elements in the center 80%

## Troubleshooting

If icons don't appear after generation:
1. Run `flutter clean`
2. Delete the `build` folder
3. Run `flutter pub get`
4. Rebuild the app

For Android, you may need to uninstall the app first:
```bash
flutter clean
flutter run
```

For iOS, clean the build folder in Xcode or run:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter run
```

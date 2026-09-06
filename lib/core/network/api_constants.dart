import 'dart:io';

class ApiConstants {
  // Use 10.0.2.2 for Android emulator, localhost for iOS simulator
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000/api/v1';
    }
    return 'http://localhost:8000/api/v1';
  }
}

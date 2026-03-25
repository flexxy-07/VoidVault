import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConfig {
  static FirebaseOptions get currentPlatform {
    if (Platform.isAndroid) {
      return android;
    } else if (Platform.isIOS) {
      return ios;
    } else if (Platform.isWindows) {
      return windows;
    } else if (Platform.isMacOS) {
      return macos;
    } else if (Platform.isLinux) {
      return linux;
    }
    throw UnsupportedError('Unsupported platform');
  }

  static FirebaseOptions get android {
    return FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
      appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
      databaseURL: dotenv.env['FIREBASE_DATABASE_URL'],
    );
  }

  static FirebaseOptions get ios {
    return FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
      appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
      databaseURL: dotenv.env['FIREBASE_DATABASE_URL'],
      iosBundleId: dotenv.env['FIREBASE_IOS_BUNDLE_ID'],
    );
  }

  static FirebaseOptions get web {
    return FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
      appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
      databaseURL: dotenv.env['FIREBASE_DATABASE_URL'],
    );
  }

  static FirebaseOptions get windows {
    return FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
      appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
      databaseURL: dotenv.env['FIREBASE_DATABASE_URL'],
    );
  }

  static FirebaseOptions get macos {
    return FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
      appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
      databaseURL: dotenv.env['FIREBASE_DATABASE_URL'],
      iosBundleId: dotenv.env['FIREBASE_MACOS_BUNDLE_ID'],
    );
  }

  static FirebaseOptions get linux {
    return FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
      appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
      databaseURL: dotenv.env['FIREBASE_DATABASE_URL'],
    );
  }
}

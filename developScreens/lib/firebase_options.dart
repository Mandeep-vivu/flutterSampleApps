// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDhOeNjZ12BM7piJE5KGVD2aEgYZZTF-qQ',
    appId: '1:387726903725:web:6323acdd56810a62e13924',
    messagingSenderId: '387726903725',
    projectId: 'developscreens-ddb84',
    authDomain: 'developscreens-ddb84.firebaseapp.com',
    databaseURL: 'https://developscreens-ddb84-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'developscreens-ddb84.appspot.com',
    measurementId: 'G-5XY2B6GLDF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkcfcGxx0mVljwcyY6sHiR1ai-dLm6LgA',
    appId: '1:387726903725:android:225f93934afe7a62e13924',
    messagingSenderId: '387726903725',
    projectId: 'developscreens-ddb84',
    databaseURL: 'https://developscreens-ddb84-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'developscreens-ddb84.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqCD42O7BqyW3G9EBOExoqoQc0bRX8BhY',
    appId: '1:387726903725:ios:9debcb9c0befca01e13924',
    messagingSenderId: '387726903725',
    projectId: 'developscreens-ddb84',
    databaseURL: 'https://developscreens-ddb84-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'developscreens-ddb84.appspot.com',
    iosBundleId: 'com.example.developscreens',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDqCD42O7BqyW3G9EBOExoqoQc0bRX8BhY',
    appId: '1:387726903725:ios:1cbf871a4e7e75e5e13924',
    messagingSenderId: '387726903725',
    projectId: 'developscreens-ddb84',
    databaseURL: 'https://developscreens-ddb84-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'developscreens-ddb84.appspot.com',
    iosBundleId: 'com.example.developscreens.RunnerTests',
  );
}

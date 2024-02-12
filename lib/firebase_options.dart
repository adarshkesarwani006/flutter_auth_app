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
    apiKey: 'AIzaSyBRxO9oeKALjkFEVv2ydgPPZu5yOVf9dVQ',
    appId: '1:38136882868:web:adf43123c64fb6e0ba59e1',
    messagingSenderId: '38136882868',
    projectId: 'flutter-login-signup-5c931',
    authDomain: 'flutter-login-signup-5c931.firebaseapp.com',
    storageBucket: 'flutter-login-signup-5c931.appspot.com',
    measurementId: 'G-8BDLFR4RCR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB30Dlc-71AsRpm47u1bmtkI0y-GgjeMK0',
    appId: '1:38136882868:android:ad91f37af907fb4dba59e1',
    messagingSenderId: '38136882868',
    projectId: 'flutter-login-signup-5c931',
    storageBucket: 'flutter-login-signup-5c931.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2dVl4eBN2xrB3bprlEjfzw_rpHxbw5a8',
    appId: '1:38136882868:ios:409f970bfdd63a52ba59e1',
    messagingSenderId: '38136882868',
    projectId: 'flutter-login-signup-5c931',
    storageBucket: 'flutter-login-signup-5c931.appspot.com',
    iosBundleId: 'com.example.flutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2dVl4eBN2xrB3bprlEjfzw_rpHxbw5a8',
    appId: '1:38136882868:ios:db47c478b190208dba59e1',
    messagingSenderId: '38136882868',
    projectId: 'flutter-login-signup-5c931',
    storageBucket: 'flutter-login-signup-5c931.appspot.com',
    iosBundleId: 'com.example.flutterApp.RunnerTests',
  );
}
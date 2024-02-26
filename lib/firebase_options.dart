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
    apiKey: 'AIzaSyCxlG3UkPZ0ADCg4_2NdifFAVwUYfh086Q',
    appId: '1:807171167314:web:0690baa6f1942b28ee7b8b',
    messagingSenderId: '807171167314',
    projectId: 'adbrokers-86765',
    authDomain: 'adbrokers-86765.firebaseapp.com',
    storageBucket: 'adbrokers-86765.appspot.com',
    measurementId: 'G-BY5R2GFC7D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwgHraxUIqs6F0QjKoVK7jPid-6-VrcAg',
    appId: '1:807171167314:android:d41e5a6218555e6fee7b8b',
    messagingSenderId: '807171167314',
    projectId: 'adbrokers-86765',
    storageBucket: 'adbrokers-86765.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPTg2Gz-qdXHCJbzDRPTksfjwliDoJZt8',
    appId: '1:807171167314:ios:2241b117f5d49a49ee7b8b',
    messagingSenderId: '807171167314',
    projectId: 'adbrokers-86765',
    storageBucket: 'adbrokers-86765.appspot.com',
    iosBundleId: 'com.example.adBrokers',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBPTg2Gz-qdXHCJbzDRPTksfjwliDoJZt8',
    appId: '1:807171167314:ios:c8765bf621636b3bee7b8b',
    messagingSenderId: '807171167314',
    projectId: 'adbrokers-86765',
    storageBucket: 'adbrokers-86765.appspot.com',
    iosBundleId: 'com.example.adBrokers.RunnerTests',
  );
}
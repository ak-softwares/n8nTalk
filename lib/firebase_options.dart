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
        return windows;
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
    apiKey: 'AIzaSyCNcVZMslVqZyp7BRopV1bC-fb59Da3EII',
    appId: '1:881736852038:web:08838a019c1b914fac2047',
    messagingSenderId: '881736852038',
    projectId: 'n8talk-edb22',
    authDomain: 'n8talk-edb22.firebaseapp.com',
    storageBucket: 'n8talk-edb22.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByt0fmMcLrOu_2Meem5k8TEwJWQMYJBhI',
    appId: '1:881736852038:android:98ef3a5858c25bc0ac2047',
    messagingSenderId: '881736852038',
    projectId: 'n8talk-edb22',
    storageBucket: 'n8talk-edb22.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxTzXyJ6ihKNr3qfZs9swyG17yCQyNY54',
    appId: '1:881736852038:ios:cd05fd1ed8c755beac2047',
    messagingSenderId: '881736852038',
    projectId: 'n8talk-edb22',
    storageBucket: 'n8talk-edb22.firebasestorage.app',
    iosBundleId: 'com.ara.chatflow',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxTzXyJ6ihKNr3qfZs9swyG17yCQyNY54',
    appId: '1:881736852038:ios:82d7e03a54d5a1ceac2047',
    messagingSenderId: '881736852038',
    projectId: 'n8talk-edb22',
    storageBucket: 'n8talk-edb22.firebasestorage.app',
    iosBundleId: 'com.example.aramarketNew',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCNcVZMslVqZyp7BRopV1bC-fb59Da3EII',
    appId: '1:881736852038:web:fb0b5a75ed474f33ac2047',
    messagingSenderId: '881736852038',
    projectId: 'n8talk-edb22',
    authDomain: 'n8talk-edb22.firebaseapp.com',
    storageBucket: 'n8talk-edb22.firebasestorage.app',
  );

}
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDm-dq0mqdQRgvZH_ToOWMTPYtFhgFUR1s',
    appId: '1:370266884116:web:c8d26bd22b94b90a3fff01',
    messagingSenderId: '370266884116',
    projectId: 'flutter-crypto-app-f4d23',
    authDomain: 'flutter-crypto-app-f4d23.firebaseapp.com',
    storageBucket: 'flutter-crypto-app-f4d23.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpPF7h6vfa7s3Lt5Sqa_GAO-XrwUDdiUU',
    appId: '1:370266884116:android:145da194cd73aaac3fff01',
    messagingSenderId: '370266884116',
    projectId: 'flutter-crypto-app-f4d23',
    storageBucket: 'flutter-crypto-app-f4d23.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkHukGAvC7ILZjL2aFWiqNaAdJux7EP4A',
    appId: '1:370266884116:ios:b4d84717938417a13fff01',
    messagingSenderId: '370266884116',
    projectId: 'flutter-crypto-app-f4d23',
    storageBucket: 'flutter-crypto-app-f4d23.appspot.com',
    iosClientId: '370266884116-maut4i4hfdk7lgemscaab3eebg2kiadc.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterCryptoApp',
  );
}
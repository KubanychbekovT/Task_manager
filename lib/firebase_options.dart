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
    apiKey: 'AIzaSyCU1aDl4g3pXn0syq1C0KBpdy5kK7NqCv8',
    appId: '1:82807448949:web:30b157176ae0ce87805f3c',
    messagingSenderId: '82807448949',
    projectId: 'taskmanager-39e18',
    authDomain: 'taskmanager-39e18.firebaseapp.com',
    storageBucket: 'taskmanager-39e18.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNs27EkDRu_SrLh1qlItGfyoSbwyxIJPM',
    appId: '1:82807448949:android:87d4cbaa7201328c805f3c',
    messagingSenderId: '82807448949',
    projectId: 'taskmanager-39e18',
    storageBucket: 'taskmanager-39e18.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3B-6IinXjorFqsxdxJbUDkBm5yiy69_8',
    appId: '1:82807448949:ios:608559eaa56c28c9805f3c',
    messagingSenderId: '82807448949',
    projectId: 'taskmanager-39e18',
    storageBucket: 'taskmanager-39e18.appspot.com',
    iosClientId: '82807448949-pk8jitln48a1mkft13af7vs7viii5883.apps.googleusercontent.com',
    iosBundleId: 'com.example.systemforschool',
  );
}

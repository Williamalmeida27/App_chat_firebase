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
    apiKey: 'AIzaSyAk4CxnQnI508j-8U8YlVcMwCbHHTxbVMw',
    appId: '1:547283315764:web:ff9180c2325780481b6e61',
    messagingSenderId: '547283315764',
    projectId: 'william-appfirebase',
    authDomain: 'william-appfirebase.firebaseapp.com',
    storageBucket: 'william-appfirebase.appspot.com',
    measurementId: 'G-H2HN4QNWF7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_s5Ybj4XzBbP23VFYJ9GhtaWrSKJrSjY',
    appId: '1:547283315764:android:5a9a1383205f2c731b6e61',
    messagingSenderId: '547283315764',
    projectId: 'william-appfirebase',
    storageBucket: 'william-appfirebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCslYQY-HipYwFY-Fj8vPx-KplwUEAwgA4',
    appId: '1:547283315764:ios:7631c9f460c0b9d41b6e61',
    messagingSenderId: '547283315764',
    projectId: 'william-appfirebase',
    storageBucket: 'william-appfirebase.appspot.com',
    iosBundleId: 'com.appfirebase.appfirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCslYQY-HipYwFY-Fj8vPx-KplwUEAwgA4',
    appId: '1:547283315764:ios:406de974212bbf821b6e61',
    messagingSenderId: '547283315764',
    projectId: 'william-appfirebase',
    storageBucket: 'william-appfirebase.appspot.com',
    iosBundleId: 'com.appfirebase.appfirebase.RunnerTests',
  );
}
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
    apiKey: 'AIzaSyA-SOG-DHSeec_wArZIWyM6GCW1rjjhFQk',
    appId: '1:123116736332:web:c1ff20dc80b6398c9249e9',
    messagingSenderId: '123116736332',
    projectId: 'raven-for-nitc',
    authDomain: 'raven-for-nitc.firebaseapp.com',
    storageBucket: 'raven-for-nitc.appspot.com',
    measurementId: 'G-X9KHNW5WX7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoSXXZQoVOvB1EimTWexbDk8Ot-ZHSBYo',
    appId: '1:123116736332:android:bc73e7e0b2ecf9f59249e9',
    messagingSenderId: '123116736332',
    projectId: 'raven-for-nitc',
    storageBucket: 'raven-for-nitc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPRQUTzhypuepKQnISDRzrE2t1aPKaqpg',
    appId: '1:123116736332:ios:e62413e55993b9519249e9',
    messagingSenderId: '123116736332',
    projectId: 'raven-for-nitc',
    storageBucket: 'raven-for-nitc.appspot.com',
    androidClientId: '123116736332-17bkqi5q9dshnsegdf8sk6nb6rmacl2u.apps.googleusercontent.com',
    iosClientId: '123116736332-j70u9c4jjatu0t75gmk1tpji68tg1519.apps.googleusercontent.com',
    iosBundleId: 'com.example.ravenForNitc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPRQUTzhypuepKQnISDRzrE2t1aPKaqpg',
    appId: '1:123116736332:ios:e62413e55993b9519249e9',
    messagingSenderId: '123116736332',
    projectId: 'raven-for-nitc',
    storageBucket: 'raven-for-nitc.appspot.com',
    androidClientId: '123116736332-17bkqi5q9dshnsegdf8sk6nb6rmacl2u.apps.googleusercontent.com',
    iosClientId: '123116736332-j70u9c4jjatu0t75gmk1tpji68tg1519.apps.googleusercontent.com',
    iosBundleId: 'com.example.ravenForNitc',
  );
}

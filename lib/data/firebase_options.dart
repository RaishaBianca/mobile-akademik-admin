import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDoZvYLeYpNy_295npikgaOG4OOXCMpL-U',
    authDomain: 'fikmobileadmin.firebaseapp.com',
    projectId: 'fikmobileadmin',
    storageBucket: 'fikmobileadmin.appspot.com',
    messagingSenderId: '999521686248',
    appId: '1:999521686248:web:4948e5690f5f23347e2f5d',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDoZvYLeYpNy_295npikgaOG4OOXCMpL-U',
    authDomain: 'fikmobileadmin.firebaseapp.com',
    projectId: 'fikmobileadmin',
    storageBucket: 'fikmobileadmin.appspot.com',
    messagingSenderId: '999521686248',
    appId: '1:999521686248:android:4948e5690f5f23347e2f5d',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoZvYLeYpNy_295npikgaOG4OOXCMpL-U',
    authDomain: 'fikmobileadmin.firebaseapp.com',
    projectId: 'fikmobileadmin',
    storageBucket: 'fikmobileadmin.appspot.com',
    messagingSenderId: '999521686248',
    appId: '1:999521686248:ios:4948e5690f5f23347e2f5d',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoZvYLeYpNy_295npikgaOG4OOXCMpL-U',
    authDomain: 'fikmobileadmin.firebaseapp.com',
    projectId: 'fikmobileadmin',
    storageBucket: 'fikmobileadmin.appspot.com',
    messagingSenderId: '999521686248',
    appId: '1:999521686248:macos:4948e5690f5f23347e2f5d',
    measurementId: 'YOUR_MEASUREMENT_ID',
  );
}
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
      apiKey: "AIzaSyAojE1-zN-G1lZMGrtaL29SG-8XoXCWZ7Q",
      authDomain: "gras-a42a7.firebaseapp.com",
      projectId: "gras-a42a7",
      storageBucket: "gras-a42a7.appspot.com",
      messagingSenderId: "251787444910",
      appId: "1:251787444910:web:48ad57c707b77ec2d9a33f",
      measurementId: "G-GMF8PYKTWW");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRSVRvhrK_Uwckm0TVMaOSXnkHam5-cJk',
    appId: '1:251787444910:android:c0fcf295b66a4213d9a33f',
    messagingSenderId: '251787444910',
    projectId: 'gras-a42a7',
    storageBucket: 'gras-a42a7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbUDFpzbRQtHzWLRNffX7bBtPTbC6KtO0',
    appId: '1:251787444910:ios:d222fbd3018ed128d9a33f',
    messagingSenderId: '251787444910',
    projectId: 'gras-a42a7',
    storageBucket: 'gras-a42a7.appspot.com',
    iosBundleId: 'com.gras.gras',
  );
}

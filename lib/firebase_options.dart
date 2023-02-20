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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-WRa__gFTgu9BVfGazP2QtsMi1S65srk',
    appId: '1:77400348289:android:7037d14d1e60056b865f80',
    messagingSenderId: '77400348289',
    projectId: 'lapoire-app',
    storageBucket: 'lapoire-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAl1S0LK8Ynuj2moa0nWAPose9Y6U2znR4',
    appId: '1:77400348289:ios:0f8e217a45a43f43865f80',
    messagingSenderId: '77400348289',
    projectId: 'lapoire-app',
    storageBucket: 'lapoire-app.appspot.com',
    androidClientId:
        '77400348289-1f2mr6fglhu73k0pm0aidf2ebo3mu9ru.apps.googleusercontent.com',
    iosClientId:
        '77400348289-r9fket3verr8dcrcpeu7rests8k2e51o.apps.googleusercontent.com',
    iosBundleId: 'com.Linktsp.Lapoire',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAl1S0LK8Ynuj2moa0nWAPose9Y6U2znR4',
    appId: '1:77400348289:ios:0f8e217a45a43f43865f80',
    messagingSenderId: '77400348289',
    projectId: 'lapoire-app',
    storageBucket: 'lapoire-app.appspot.com',
    androidClientId:
        '77400348289-1f2mr6fglhu73k0pm0aidf2ebo3mu9ru.apps.googleusercontent.com',
    iosClientId:
        '77400348289-r9fket3verr8dcrcpeu7rests8k2e51o.apps.googleusercontent.com',
    iosBundleId: 'com.Linktsp.Lapoire',
  );
}

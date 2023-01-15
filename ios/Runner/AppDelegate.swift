import UIKit
import Flutter
import GoogleMaps
import FBAudienceNetwork

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FBAdSettings.setAdvertiserTrackingEnabled(true)
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyAl1S0LK8Ynuj2moa0nWAPose9Y6U2znR4")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

import UIKit
import Flutter
import Firebase
import Evergage

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let evergage = Evergage.sharedInstance()

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let CHANNEL = FlutterMethodChannel(name: "demo.sfmc_cumulus/info", binaryMessenger: controller.binaryMessenger)
    
    CHANNEL.setMethodCallHandler {[unowned self] (methodCall, result) in
        if methodCall.method == "interactionstudioInitialize"
        {
            var account: String?
            var ds: String?
            
            if let args = methodCall.arguments as? Dictionary<String, AnyObject>
            {
                account = args["account"] as? String
                ds = args["ds"] as? String
            }
            if account!.isEmpty || ds!.isEmpty {
                result("Could not connect to Interaction Studio")
            }else{
                //result("Hi from Swift: " + account! + ds!)
                // Recommended to set the authenticated user's ID as soon as known:
                evergage.userId = "iOSUser"
                // Start Evergage with your Evergage Configuration:
                evergage.start { (clientConfigurationBuilder) in
                    clientConfigurationBuilder.account = account!
                    clientConfigurationBuilder.dataset = ds!
                    clientConfigurationBuilder.usePushNotifications = true
                    clientConfigurationBuilder.useDesignMode = true
                }

            }
        }
        if methodCall.method == "interactionstudioLogEvent"
        {
            var event: String?
            var description: String?

            if let args = methodCall.arguments as? Dictionary<String, AnyObject>
            {
                event = args["event"] as? String
                description = args["description"] as? String
            }
            
            //Need to handle different types of events, not just generic trackAction
            evergage.globalContext?.trackAction(description!)
        }
    }

    
    GeneratedPluginRegistrant.register(with: self)
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override init() { FirebaseApp.configure() }
}

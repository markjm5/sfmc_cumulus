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

    //let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

    let controller : EVGViewController = window?.rootViewController as! EVGViewController

    
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
                        
            switch event
            {
                case "setUserId":
                    evergage.userId = description!

                case "viewCategory":
                    var a:EVGCategory?
                    a = description! as? EVGCategory
                    evergage.globalContext?.viewCategory(a!)

                case "viewTag":
                    var a:EVGTagType?
                    a = EVGTagType.init(rawValue: 0) //This integer needs to be dynamic
                    evergage.globalContext?.viewTag(EVGTag.init(id:description!, type:a!))

                case "viewItem":
                    evergage.globalContext?.viewItem(EVGProduct.init(id:description!))
                
                //case "viewItemDetail":
                //  var a:EVGItem?
                //  a = description! as? EVGItem
                //  evergage.globalContext?.viewItemDetail(a!, "blah")

                default:
                    evergage.globalContext?.trackAction(description!)

            }
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

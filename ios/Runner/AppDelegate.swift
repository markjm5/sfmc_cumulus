import UIKit
import Flutter
import Firebase
import Evergage

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var activeCampaign:EVGCampaign?
    var strResult:String?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let evergage = Evergage.sharedInstance()
        
        //let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let controller : EVGViewController = window?.rootViewController as! EVGViewController

        // Note self is captured weakly
        let handler = { [weak self] (campaign: EVGCampaign) -> Void in
            // Safest to perform a single method/operation on weakSelf, which will simply be a no-op if weakSelf is nil:
            self?.handleCampaign(campaign: campaign, controller: controller)
            
        }
        
        // The target string uniquely identifies the expected data schema - here, a featured product:
        controller.evergageScreen?.setCampaignHandler(handler, forTarget: "cumulusFeaturedProduct")

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
                    //result("Could not connect to Interaction Studio")
                    self.strResult = "Could not connect to Interaction Studio"
                }else{
                    // Start Evergage with your Evergage Configuration:
                    evergage.start { (clientConfigurationBuilder) in
                        clientConfigurationBuilder.account = account!
                        clientConfigurationBuilder.dataset = ds!
                        clientConfigurationBuilder.usePushNotifications = true
                        clientConfigurationBuilder.useDesignMode = true
                        self.strResult = "Connected to Interaction Studio"
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
                    
                //case "viewCategory":
                //    var a:EVGCategory?
                //    a = description! as? EVGCategory
                //    evergage.globalContext?.viewCategory(a!)
                    
                case "viewTag":
                    var evgTagType:EVGTagType?
                    
                    //var tagId: String?
                    //var tagType: Int?
                    // Split description var by pipe, assign each component of string to the above 2 vars
                    // Replace vars below (id, type) with the above 2 vars
                    
                    evgTagType = EVGTagType.init(rawValue: 0) //This integer needs to be dynamic
                    //evergage.globalContext?.viewTag(EVGTag.init(id:description!, type:evgTagType!))
                    controller.evergageScreen?.viewTag(EVGTag.init(id:description!, type:evgTagType!))
                    
                case "viewItem":
                    
                    //evergage.globalContext?.viewItem(EVGProduct.init(id:description!))

                    controller.evergageScreen?.viewItem(EVGProduct.init(id:description!))
                    
                    //var strCampaignName:String?
                    
                    //strCampaignName = controller.campaign?.campaignName
                    //if strCampaignName == nil {
                    //    strResult = "Campaign Name: NIL"
                    //}
                    //else{
                    //    strResult = "Campaign Name: " + strCampaignName!
                        
                    //}
                    //case "viewItemDetail":
                    //  var a:EVGItem?
                    //  a = description! as? EVGItem
                    //  evergage.globalContext?.viewItemDetail(a!, "blah")
                    
                default:
                    //evergage.globalContext?.trackAction(description!)
                    controller.evergageScreen?.trackAction(description!)
                    
                }
            }

            if self.activeCampaign != nil {
                self.strResult = "Campaign Name: " + self.activeCampaign!.campaignName
            }else {
                self.strResult = "No Campaign Returned"
            }

            result(self.strResult)
        }
        
        
        GeneratedPluginRegistrant.register(with: self)
        //if FirebaseApp.app() == nil {
        //    FirebaseApp.configure()
        //}
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    func handleCampaign(campaign: EVGCampaign, controller: EVGViewController) {
        
        // Validate the campaign data since it's dynamic JSON. Avoid processing if fails.
        //let featuredProductName = campaign.data["promotedProduct"] as? String
        
        // Track the impression for statistics even if the user is in the control group.
        controller.evergageScreen?.trackImpression(campaign)
        self.activeCampaign = campaign
    }
    
    //override init() { FirebaseApp.configure() }
}

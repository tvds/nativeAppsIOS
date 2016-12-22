import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let model = ScoreModel()
        model.setDummyData()
        let scoresViewController = (window!.rootViewController as! UINavigationController).topViewController as! ScoresViewController
        scoresViewController.model = model
        return true
    }
}

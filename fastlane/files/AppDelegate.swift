import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        registerFlutterChannelPlugin(registry: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    /// 註冊自訂插件
    private func registerFlutterChannelPlugin(registry: FlutterPluginRegistry) {
        let flutterController = self.window.rootViewController as! FlutterViewController
        FlutterChannel.register(with: flutterController)
    }
}

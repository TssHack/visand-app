import Flutter
import UIKit
import UserNotifications
import LocalAuthentication

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Configure notification center
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        
        // Request notification permissions
        requestNotificationPermissions()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // MARK: - URL Handling
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Handle incoming URLs (http, https, mailto, tel, sms, whatsapp, telegram)
        return handleIncomingURL(url)
    }
    
    // MARK: - Document Handling
    override func application(_ application: UIApplication, didReceive url: URL) {
        // Handle document opening (PDF, Image, Text)
        handleDocumentOpening(url)
    }
    
    // MARK: - Notification Handling
    func requestNotificationPermissions() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
    }
    
    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter, 
                                        didReceive response: UNNotificationResponse, 
                                        withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle notification actions
        handleNotificationAction(response)
        completionHandler()
    }
    
    // MARK: - Authentication
    func authenticateWithFaceID(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "برای ورود امن به اپلیکیشن می‌توانید از Face ID استفاده کنید"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                completion(success, error)
            }
        } else {
            completion(false, error)
        }
    }
    
    // MARK: - Helper Methods
    private func handleIncomingURL(_ url: URL) -> Bool {
        // Implement URL handling logic
        // Example: Process deep links or external app calls
        return true
    }
    
    private func handleDocumentOpening(_ url: URL) {
        // Implement document handling logic
        // Example: Process PDF, Image or Text files
    }
    
    private func handleNotificationAction(_ response: UNNotificationResponse) {
        let actionIdentifier = response.actionIdentifier
        
        switch actionIdentifier {
        case "VIEW_ACTION":
            // Handle "مشاهده" action
            break
        case "DISMISS_ACTION":
            // Handle "نادیده گرفتن" action
            break
        default:
            break
        }
    }
}
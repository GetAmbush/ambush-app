import Flutter
import UIKit
import Combine

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let fileWriteUseCase = FileWriteUseCase()
    private let fileReadUseCase = FileReadUseCase()
    private var writeSubscription: AnyCancellable?
    private var readSubscription: AnyCancellable?
    
    var topmostViewController: UIViewController? {
        var nextVC = self.window?.rootViewController
        
        while let currentVC = nextVC {
            if let navVC = currentVC as? UINavigationController {
                nextVC = navVC.topViewController
            } else if let presentedVC = currentVC.presentedViewController {
                nextVC = presentedVC
            } else {
                break
            }
        }
        
        return nextVC
    }
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "flutter.dev/preferences",
                                                  binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard let self else { return }
            switch call.method {
            case "create_backup": handleCreateBackup(arguments: call.arguments, result: result)
            case "restore_backup": handleRestoreBackup(result: result)
            default: result(FlutterMethodNotImplemented)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func handleCreateBackup(arguments: Any?, result: @escaping FlutterResult) {
        writeSubscription = fileWriteUseCase
            .pathPublisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    result(FlutterError(code: "", message: error.message, details: nil))
                }
            }, receiveValue: { result(["path": $0]) })
        
        guard let arguments = arguments as? [String: Any],
              let data = arguments["data"] as? String else {
            result(FlutterMethodNotImplemented)
            return
        }
        fileWriteUseCase.write(data, vc: topmostViewController)
    }
    
    private func handleRestoreBackup(result: @escaping FlutterResult) {
        readSubscription = fileReadUseCase
            .contentPublisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    result(FlutterError(code: "", message: error.message, details: nil))
                }
            }, receiveValue: { result($0) })
        fileReadUseCase.read(topmostViewController)
    }
}

//
//  AppDelegate.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Vars
    var window: UIWindow?
    
    // MARK: - Lifecycle
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        initWith(viewController: ArticlesListVC())
        return true
    }
}

// MARK: - RootViewController
extension AppDelegate {
    
    func initWith(viewController: UIViewController) {
        let windowFrame = UIScreen.main.bounds
        window = UIWindow(frame: windowFrame)
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

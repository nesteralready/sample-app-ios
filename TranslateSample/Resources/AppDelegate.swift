//
//  AppDelegate.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 19.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let viewControllersAssembly = ViewControllerAssembly()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        setInitialViewController()
        return true
    }
    
    private func setInitialViewController() {
           let initialNavigationController = UINavigationController()
           let router = TranslaterRouter(navigationController: initialNavigationController,
                                         viewControllerAssembly: viewControllersAssembly)
           router.initialViewController()
           self.window?.rootViewController = initialNavigationController
           self.window?.makeKeyAndVisible()
       }
}


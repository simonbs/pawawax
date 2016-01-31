//
//  AppDelegate.swift
//  Pawawaps
//
//  Created by Simon Støvring on 29/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            FirstSampleViewController(),
            SecondSampleViewController()
        ]
        return tabBarController
    }
}


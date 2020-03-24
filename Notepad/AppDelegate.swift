//
//  AppDelegate.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/2.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainNaviVC = MainNavigationViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainNaviVC
        window?.makeKeyAndVisible()
        return true
    }


}


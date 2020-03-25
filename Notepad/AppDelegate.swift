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

    func applicationDidEnterBackground(_ application: UIApplication) {
        addShortCut()
    }

}

extension AppDelegate {
    func addShortCut() {
        var resultShortCutArray: Array<UIApplicationShortcutItem> = []
        
        if UserDataManager.default.userNoteData.count >= 1 {
            let firstNote = UIApplicationShortcutItem(type: "com.Johnny.first.note", localizedTitle: UserDataManager.default.userNoteData[0].title, localizedSubtitle: UserDataManager.default.userNoteData[0].detail, icon: UIApplicationShortcutIcon(type: .compose), userInfo: nil)
            resultShortCutArray.append(firstNote)
        }
        if UserDataManager.default.userNoteData.count >= 2 {
            let secondNote = UIApplicationShortcutItem(type: "com.Johnny.second.note", localizedTitle: UserDataManager.default.userNoteData[1].title, localizedSubtitle: UserDataManager.default.userNoteData[1].detail, icon: UIApplicationShortcutIcon(type: .compose), userInfo: nil)
            resultShortCutArray.append(secondNote)
        }
        if UserDataManager.default.userNoteData.count >= 3 {
            let secondNote = UIApplicationShortcutItem(type: "com.Johnny.second.note", localizedTitle: UserDataManager.default.userNoteData[2].title, localizedSubtitle: UserDataManager.default.userNoteData[2].detail, icon: UIApplicationShortcutIcon(type: .compose), userInfo: nil)
            resultShortCutArray.append(secondNote)
        }
        
        
        UIApplication.shared.shortcutItems = resultShortCutArray
    }
}

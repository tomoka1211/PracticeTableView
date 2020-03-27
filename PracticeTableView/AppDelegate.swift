//
//  AppDelegate.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/07/31.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var myNavigationController: UINavigationController?
    
    private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        // ViewControllerを生成.
        let myViewController: ViewController = ViewController()
        
        // Navication Controllerを生成.
        myNavigationController = UINavigationController(rootViewController: myViewController)
        
        // UIWindowを生成.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // rootViewControllerにNavigationControllerを設定.
        self.window?.rootViewController = myNavigationController
        
        self.window?.makeKeyAndVisible()
       
        IQKeyboardManager.shared().isEnabled = true
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

private let host = "https://cloud.githubusercontent.com/assets"
let demoPhotosURLs = [
    URL(string: "\(host)/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg")!,
    URL(string: "\(host)/1567433/9781832/0719dd5e-57a1-11e5-9324-9764de25ed47.jpg")!,
    URL(string: "\(host)/1567433/9781833/09021316-57a1-11e5-817b-85b57a2a8a77.jpg")!,
    URL(string: "\(host)/1567433/9781834/0931ad74-57a1-11e5-9080-c8f6ecea19ce.jpg")!,
    URL(string: "\(host)/1567433/9781838/0e6274f4-57a1-11e5-82fd-872e735eea73.jpg")!,
    URL(string: "\(host)/1567433/9781839/0e63ad92-57a1-11e5-8841-bd3c5ea1bb9c.jpg")!,
    URL(string: "\(host)/1567433/9781843/0f4064b2-57a1-11e5-9fb7-f258e81a4214.jpg")!,
    URL(string: "\(host)/1567433/9781840/0e95f978-57a1-11e5-8179-36dfed72f985.jpg")!,
    URL(string: "\(host)/1567433/9781841/0e96b5fc-57a1-11e5-82ae-699b113bb85a.jpg")!
]
let demoPhotosURLs1 = [
    URL(string: "\(host)/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg")!,
    URL(string: "\(host)/1567433/9781832/0719dd5e-57a1-11e5-9324-9764de25ed47.jpg")!,
    URL(string: "\(host)/1567433/9781833/09021316-57a1-11e5-817b-85b57a2a8a77.jpg")!,
    URL(string: "\(host)/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg")!,
    URL(string: "\(host)/1567433/9781832/0719dd5e-57a1-11e5-9324-9764de25ed47.jpg")!,
    URL(string: "\(host)/1567433/9781833/09021316-57a1-11e5-817b-85b57a2a8a77.jpg")!
]
let demoPhotosURLs2 = [
    URL(string: "\(host)/1567433/9781834/0931ad74-57a1-11e5-9080-c8f6ecea19ce.jpg")!,
    URL(string: "\(host)/1567433/9781838/0e6274f4-57a1-11e5-82fd-872e735eea73.jpg")!,
    URL(string: "\(host)/1567433/9781839/0e63ad92-57a1-11e5-8841-bd3c5ea1bb9c.jpg")!,
    URL(string: "\(host)/1567433/9781834/0931ad74-57a1-11e5-9080-c8f6ecea19ce.jpg")!,
    URL(string: "\(host)/1567433/9781838/0e6274f4-57a1-11e5-82fd-872e735eea73.jpg")!,
    URL(string: "\(host)/1567433/9781839/0e63ad92-57a1-11e5-8841-bd3c5ea1bb9c.jpg")!
]
let demoPhotosURLs3 = [
    URL(string: "\(host)/1567433/9781843/0f4064b2-57a1-11e5-9fb7-f258e81a4214.jpg")!,
    URL(string: "\(host)/1567433/9781840/0e95f978-57a1-11e5-8179-36dfed72f985.jpg")!,
    URL(string: "\(host)/1567433/9781841/0e96b5fc-57a1-11e5-82ae-699b113bb85a.jpg")!,
    URL(string: "\(host)/1567433/9781843/0f4064b2-57a1-11e5-9fb7-f258e81a4214.jpg")!,
    URL(string: "\(host)/1567433/9781840/0e95f978-57a1-11e5-8179-36dfed72f985.jpg")!,
    URL(string: "\(host)/1567433/9781841/0e96b5fc-57a1-11e5-82ae-699b113bb85a.jpg")!
]

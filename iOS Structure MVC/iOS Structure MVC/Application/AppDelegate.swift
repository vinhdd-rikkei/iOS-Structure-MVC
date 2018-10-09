//
//  AppDelegate.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Constants
    static let shared = UIApplication.shared.delegate as? AppDelegate
    
    // MARK: - Variables
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set Loading Screen as root screen
        let loadingVC = ViewControllerTask.type(LoadingVC.self)
        SystemBoots.instance.bootsFor(window: &window, rootController: loadingVC)
        
        // Check where app has launched
        checkWhereAppHasLaunchedWith(application: application, launchOptions: launchOptions)
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NotificationService.instance.parseDeviceToken(data: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        NotificationService.instance.received(localNotification: notification, application: application)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NotificationService.instance.received(remoteNotification: userInfo, application: application)
    }
}

// MARK: - Application States
extension AppDelegate {
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        SystemBoots.instance.appWillResignActive(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        SystemBoots.instance.appDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        SystemBoots.instance.appWillEnterForeground(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        SystemBoots.instance.appDidBecomeActive(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        SystemBoots.instance.appWillTerminate(application)
    }
}


// MARK: - Supporting functions
extension AppDelegate {
    private func checkWhereAppHasLaunchedWith(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        //Detect where app has launched
        if let localNotification = launchOptions?[.localNotification] as? UILocalNotification {
            // Launched via Local Notification
            self.application(application, didReceive: localNotification)
        } else if let payloadRemoteNotification = launchOptions?[.remoteNotification] as? [AnyHashable : Any] {
            // Launched via Remote Notification
            self.application(application, didReceiveRemoteNotification: payloadRemoteNotification, fetchCompletionHandler: { _ in })
        } else if (launchOptions?[.url] != nil || launchOptions?[.userActivityDictionary] != nil) {
            // Launched via another app
            // Do nothing
        }
    }
}

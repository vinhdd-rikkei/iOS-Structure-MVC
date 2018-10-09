//
//  SystemBoots.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftyJSON

class SystemBoots {
    
    // MARK: - Singleton
    static let instance = SystemBoots()
    
    // MARK: - Variables
    weak var appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    // MARK: - Actions
    func bootsFor(window: inout UIWindow?, rootController: UIViewController) {
        // Setup app's window
        guard window == nil else { return }
        window = UIWindow(frame: AppConstants.screenBounds)
        window?.backgroundColor = .white
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()

        // Config app
        basicAppConfig()
    }
    
    // MARK: - Setup
    private func basicAppConfig() {
        // TODO: - Setup basic configuration for app
    }
    
    // MARK: - Builder
    func setRoot(controller: UIViewController) {
        appDelegate?.window?.rootViewController = controller
    }
}

extension SystemBoots {
    func appWillResignActive(_ application: UIApplication) {
        // Do nothing
    }
    
    func appDidEnterBackground(_ application: UIApplication) {
        // Do nothing
    }
    
    func appWillEnterForeground(_ application: UIApplication) {
        // Do nothing
    }
    
    func appDidBecomeActive(_ application: UIApplication) {
        // Do nothing
    }
    
    func appWillTerminate(_ application: UIApplication) {
        // Do nothing
    }
}

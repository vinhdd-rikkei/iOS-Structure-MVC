//
//  NotificationService.swift
//  Hemophilia_iOS
//
//  Created by vinhdd on 8/10/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import UserNotifications
import PushKit
import CallKit

class NotificationService: NSObject {
    
    // MARK: - Singleton
    static var instance = NotificationService()
    var pushRegistry: PKPushRegistry?
    
    // Cache push notification data to show (when app is killed or not being opened)
    var launchRemoteData: [AnyHashable : Any]?
    
    // MARK: - Register push notification
    func registerPushNotification(application: UIApplication = UIApplication.shared, completion: (() -> Void)? = nil) {
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions,
                                                                    completionHandler: { granted, error in
                    DispatchQueue.main.async {
                        if error == nil && granted {
                            application.registerForRemoteNotifications()
                        }
                        completion?()
                    }
                }
            )
            UNUserNotificationCenter.current().delegate = self
        } else {
            let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
            application.registerForRemoteNotifications()
            completion?()
        }
    }
    
    // MARK: - Supporting methods
    func didRegisterForPushNotification() -> Bool {
        let notificationType = UIApplication.shared.currentUserNotificationSettings?.types
        return notificationType == [] ? false : true
    }
    
    func getAmountOfPendingLocalNotifications(completion: @escaping ((_ count: Int) -> Void)) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests in
                DispatchQueue.main.async {
                    completion(requests.count)
                }
            })
        } else {
            let count = (UIApplication.shared.scheduledLocalNotifications ?? []).count
            completion(count)
        }
    }
    
    func removeAllLocalNotifications(removeDelivered: Bool = false, completion: @escaping (() -> Void)) {
        let application = UIApplication.shared
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.getPendingNotificationRequests(completionHandler: { requests in
                DispatchQueue.main.async {
                    let removeIds = requests.map({ $0.identifier })
                    center.removePendingNotificationRequests(withIdentifiers: removeIds)
                    print("[Local Notification] Removed all ! (iOS >= 10)")
                    completion()
                }
            })
            if removeDelivered {
                center.getDeliveredNotifications(completionHandler: { notifications in
                    DispatchQueue.main.async {
                        let removeIds = notifications.map { $0.request.identifier }
                        center.removeDeliveredNotifications(withIdentifiers: removeIds)
                    }
                })
            }
        } else {
            if let localNotis = application.scheduledLocalNotifications {
                localNotis.forEach {
                    application.cancelLocalNotification($0)
                }
                print("[Local Notification] Removed all ! (iOS < 10)")
            }
            completion()
        }
    }
    
    func removeLocalNotificationsWith(identifier: String,
                                            removeDelivered: Bool = false,
                                            completion: @escaping (() -> Void)) {
        let application = UIApplication.shared
        let identifierKey = AppConstants.localNotiIdentifierKey
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            func removeDeliveredIfNeeded() {
                if removeDelivered {
                    center.getDeliveredNotifications(completionHandler: { notifications in
                        DispatchQueue.main.async {
                            var removeIds = [String]()
                            for noti in notifications {
                                let request = noti.request
                                if let id = request.content.userInfo[identifierKey] as? String, id == identifier {
                                    removeIds.append(request.identifier)
                                }
                            }
                            center.removeDeliveredNotifications(withIdentifiers: removeIds)
                            completion()
                        }
                    })
                } else { completion() }
            }
            center.getPendingNotificationRequests(completionHandler: { requests in
                DispatchQueue.main.async {
                    let removeIds = requests.filter({
                        if let id = $0.content.userInfo[identifierKey] as? String {
                            return id == identifier
                        }
                        return false
                    }).map({ $0.identifier })
                    center.removePendingNotificationRequests(withIdentifiers: removeIds)
                    print("[Local Notification][Type: \(identifier)] Removed all ! (iOS >= 10)")
                    if removeDelivered { removeDeliveredIfNeeded() }
                    else { completion() }
                }
            })
        } else {
            if let localNotifications = application.scheduledLocalNotifications {
                let targetList = localNotifications.filter({
                    if let id = $0.userInfo?[identifierKey] as? String {
                        return id == identifier
                    }
                    return false
                })
                targetList.forEach {
                    application.cancelLocalNotification($0)
                }
                print("[Local Notification][Type: \(identifier)] Removed all ! (iOS < 10)")
            }
            completion()
        }
    }
}

// MARK: - Handle device token
extension NotificationService {
    func parseDeviceToken(data: Data) {
        let deviceToken = data.reduce("", {$0 + String(format: "%02X", $1)})
        SharedData.notificationToken = deviceToken
        sendDeviceTokenToServer(deviceToken: deviceToken)
    }
    
    func sendDeviceTokenToServer(deviceToken: String, completion: (() -> Void)? = nil) {
        print("[PUSH NOTIFICATION] - Device Token: \(deviceToken)")
        // TODO: - Send device token to server
    }
}

// MARK: - Handle push notification & local notification data
extension NotificationService {
    // MARK: - Receive data from remote & local notifications
    func received(remoteNotification userInfo: [AnyHashable: Any], application: UIApplication) {
        parse(remoteNotification: userInfo, for: application)
    }
    
    func received(localNotification noti: UILocalNotification, application: UIApplication) {
        parse(localNotification: noti, for: application)
    }
    
    // MARK: - Parse data from remote & local notifications
    private func parse(remoteNotification userInfo: [AnyHashable: Any], for application: UIApplication) {
        // TODO - Parse push notification data
    }
    
    private func parse(localNotification noti: UILocalNotification, for application: UIApplication) {
        print("[LOCAL NOTIFICATION] - Local notification \(application.applicationState) received:\n\(JSON(noti.userInfo ?? [:]))\n")
        // TODO - Parse local notification data
    }
}

@available(iOS 10.0, *)
extension NotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        parse(remoteNotification: response.notification.request.content.userInfo, for: UIApplication.shared)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let jsonData = JSON(notification.request.content.userInfo)
        print("[USER NOTIFICATION CENTER] - Received response:\n\(jsonData)\n")
        completionHandler([.alert, .badge, .sound])
    }
}

//
//  SharedData.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

// MARK: - General information
class SharedData {
    
    // Check sandbox enviroment or not
    #if DEVELOP || STAGING
    static let isSandboxEnviroment: Bool = true
    #else
    static let isSandboxEnviroment: Bool = false
    #endif
    
    // Login id cache in app, use to sign in automatically if needed
    class var loginId: String? {
        get {
            let getValue = DataService.quickGet(type: String.self, forKey: "LoginId")
            return getValue?.decryptAES
        }
        set(value) {
            let encryptValue = value?.encryptAES
            DataService.quickSave(value: encryptValue, forKey: "LoginId")
        }
    }
    
    // Login pass cache in app, use to sign in automatically if needed
    class var loginPassword: String? {
        get {
            let getValue = DataService.quickGet(type: String.self, forKey: "LoginPassword")
            return getValue?.decryptAES
        }
        set(value) {
            let encryptValue = value?.encryptAES
            DataService.quickSave(value: encryptValue, forKey: "LoginPassword")
        }
    }
    
    // Access token for requesting APIs
    class var accessToken: String? {
        get {
            return DataService.quickGet(type: String.self, forKey: "ApiAccessToken")
        }
        set(value) {
            DataService.quickSave(value: value, forKey: "ApiAccessToken")
        }
    }
    
    // APNS token is saved in app
    class var notificationToken: String? {
        get {
            return DataService.quickGet(type: String.self, forKey: "NotificationToken")
        }
        set(value) {
            DataService.quickSave(value: value, forKey: "NotificationToken")
        }
    }
    
    // Check if this is the first time using app
    class var isUsingAppFirstTime: Bool? {
        get {
            return DataService.quickGet(type: Bool.self, forKey: "IsUsingAppFirstTime")
        }
        set(value) {
            DataService.quickSave(value: value, forKey: "IsUsingAppFirstTime")
        }
    }
}

//
//  AppConstants.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

// MARK: - General information
class AppConstants {
    static let screenBounds = UIScreen.main.bounds
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let screenNativeBounds = UIScreen.main.nativeBounds
    static let screenNativeWidth = UIScreen.main.nativeBounds.width
    static let screenNativeHeight = UIScreen.main.nativeBounds.height
    
    static let iphone3point5InchesHeight: CGFloat = 480 // iphone 4s and below
    static let iphone4InchesHeight: CGFloat = 568 // iphone 4s -> iphone 5s || iphone SE
    static let iphone4point7InchesHeight: CGFloat = 667 // iphone 6 & 7 & 8
    static let iphone5point5InchesHeight: CGFloat = 736 // iphone 6+ & 7+ & 8+
    static let iphone5point8InchesHeight: CGFloat = 812 // iphone X
    static let iphone6point5InchesHeight: CGFloat = 896 // iphone XS Max
    
    static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    
    static let shiftJISEncoding = String.Encoding.shiftJIS
    static let utf8Encoding = String.Encoding.utf8
    
    static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let osName = UIDevice.current.systemName
    static let osVersion = UIDevice.current.systemVersion
    
    static var appIdOnAppStore: String? {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
    }
    
    static var appInfoOnAppStoreUrl: URL? {
        if let appId = AppConstants.appIdOnAppStore {
            let urlStr = String(format: "http://itunes.apple.com/lookup?bundleId=%@", appId)
            return URL(string: urlStr)
        }
        return nil
    }
}

// MARK: - General data
extension AppConstants {
    static var calendar: Calendar {
        return Calendar(identifier: .gregorian)
    }
    static var timeZone: TimeZone {
        return TimeZone.ReferenceType.local
    }
    
    static let emptyString = ""
    static let localNotiIdentifierKey = "Identifier"
}

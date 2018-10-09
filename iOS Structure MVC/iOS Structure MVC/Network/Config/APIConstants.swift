//
//  APIConstants.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Alamofire
// swiftlint:disable colon

class APIConstants {
    static var baseUrl: String {
        #if DEVELOP || STAGING
        return ""
        #else
        return ""
        #endif
    }
    
    static var httpHeaders: HTTPHeaders {
        #if DEVELOP || STAGING
        return [:]
        #else
        return [:]
        #endif
    }
}

// Describe common format for api response's content
extension APIConstants {
    static let dateFormat = "yyyy/MM/dd"
    static let dateTimeFormat = "yyyy/MM/dd HH:mm:ss"
    static let dateTimeWithoutSecondFormat = "yyyy/MM/dd HH:mm"
    static let birthdayDateFormat = "yyyy/MM"
    static let timeFormat = "HH:mm"
    static let timeSecondFormat = "hh:mm:ss.SSS"
    static let dateHourTimeFormat = "yyyy/MM/dd HH:mm:ss"
}

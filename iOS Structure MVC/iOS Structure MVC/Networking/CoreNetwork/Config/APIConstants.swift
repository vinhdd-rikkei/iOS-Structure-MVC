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
        return "https://api.stackexchange.com/2.2"
        #else
        return "https://api.stackexchange.com/2.2"
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

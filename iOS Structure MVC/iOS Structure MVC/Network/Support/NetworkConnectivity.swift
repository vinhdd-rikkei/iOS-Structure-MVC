//
//  NetworkConnectivity.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Alamofire

class NetworkConnectivity {
    static func hasInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

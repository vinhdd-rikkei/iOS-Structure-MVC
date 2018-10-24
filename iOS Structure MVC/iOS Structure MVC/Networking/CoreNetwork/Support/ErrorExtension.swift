//
//  ErrorExtension.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

extension Error {
    var errorCode: Int? {
        return (self as NSError).code
    }
    
    func isInternetOffline() -> Bool {
        return (self as? URLError)?.code  == .notConnectedToInternet
    }
    
    func isTimeout() -> Bool {
        return (self as? URLError)?.code  == .timedOut
    }
}

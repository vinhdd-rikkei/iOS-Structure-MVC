//
//  ErrorExtension.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

extension Error {
    func isInternetOffline() -> Bool {
        return (self as? URLError)?.code  == .notConnectedToInternet
    }
}

//
//  DataService.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class DataService {
    static func quickSave(value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func quickGet<T>(type: T.Type, forKey key: String) -> T? {
        return UserDefaults.standard.object(forKey: key) as? T
    }
}

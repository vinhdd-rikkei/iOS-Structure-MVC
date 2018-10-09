//
//  DatabaseService.swift
//  Hemophilia_iOS
//
//  Created by vinhdd on 8/12/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
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

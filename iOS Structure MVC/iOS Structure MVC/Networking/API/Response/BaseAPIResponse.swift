//
//  BaseAPIResponse.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseAPIResponse: ModelResponseProtocol {
    
    required init(json: JSON) {
        // Do nothing
    }
    
    func printInfo() {
        print("-> Requested successfully !!")
    }
}

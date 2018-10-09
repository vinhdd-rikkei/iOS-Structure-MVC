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
    
    var request: Request
    
    required init(json: JSON, request: Request) {
        self.request = request
    }
    
    func printInfo() {
        print("-> [\(request.apiIdentifier)] Requested successfully !!")
    }
}

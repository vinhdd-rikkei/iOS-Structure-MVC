//
//  LoginAPI.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginAPI: OperationTask<LoginResponse> {
    
    var id: String
    var pass: String
    
    override var request: Request! {
        return AuthRequest.login(id: id, pass: pass)
    }
    init(id: String, pass: String) {
        self.id = id
        self.pass = pass
    }
}

class LoginResponse: BaseAPIResponse {
    
    required init(json: JSON, request: Request) {
        super.init(json: json, request: request)
        // Parse json data from server to local variables
    }
}

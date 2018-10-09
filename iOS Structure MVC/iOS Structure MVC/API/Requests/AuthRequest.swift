//
//  AuthRequest.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Alamofire

public enum AuthRequest: Request {
    case login(id: String, pass: String)
    case logout()
    
    public var apiIdentifier: String {
        switch self {
        case .login:
            return "API0001 ⬩ Login"
        case .logout:
            return "API0002 ⬩ Logout"
        }
    }
    
    public var path: String {
        switch self {
        case .login:
            return "user/login"
        case .logout:
            return "user/logout"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .login, .logout:
            return .post
        }
    }
    
    public var parameters: RequestParams {
        var baseParams: Parameters = [:]
        switch self {
        case .login(let id, let pass):
            baseParams["login_id"] = id
            baseParams["password"] = pass
            
        case .logout:
            break
        }
        return .body(baseParams)
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
    
    public var dataType: DataType {
        return .json
    }
}


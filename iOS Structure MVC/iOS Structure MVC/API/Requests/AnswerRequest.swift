//
//  AuthRequest.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Alamofire

public enum AnswerRequest: Request {
    case getAnswerList(order: String, sort: String, site: String)
    
    // This variable is used for debugging (print in console)
    public var apiIdentifier: String {
        switch self {
        case .getAnswerList:
            return "API0001 ⬩ Get answer"
        }
    }
    
    public var path: String {
        switch self {
        case .getAnswerList:
            return "answers"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getAnswerList:
            return .get
        }
    }
    
    public var parameters: RequestParams {
        var baseParams: Parameters = [:]
        switch self {
        case .getAnswerList(let order, let sort, let site):
            baseParams["order"] = order
            baseParams["sort"] = sort
            baseParams["site"] = site
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


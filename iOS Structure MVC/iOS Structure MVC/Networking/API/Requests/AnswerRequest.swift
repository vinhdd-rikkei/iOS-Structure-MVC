//
//  AuthRequest.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Alamofire

public enum AnswerRequest: RequestProtocol {
    case getAnswerList(order: String, sort: String, site: String)
    case postAnswer(text: String)
    
    // This variable is used for debugging (print in console)
    public var id: String {
        switch self {
        case .getAnswerList:
            return "API0001 ⬩ Get answer"
        case .postAnswer:
            return "API0002 ⬩ Post answer"
        }
    }
    
    public var path: String {
        switch self {
        case .getAnswerList, .postAnswer:
            return "answers"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getAnswerList:
            return .get
        case .postAnswer:
            return .post
        }
    }
    
    public var parameters: RequestParams {
        var baseParams: Parameters = [:]
        switch self {
        case .getAnswerList(let order, let sort, let site):
            baseParams["order"] = order
            baseParams["sort"] = sort
            baseParams["site"] = site
        case .postAnswer(let text):
            baseParams["text"] = text
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


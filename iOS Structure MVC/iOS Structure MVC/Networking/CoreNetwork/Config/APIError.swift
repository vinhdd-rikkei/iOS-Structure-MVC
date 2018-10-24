//
//  ErrorExtension.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

enum APIErrorType {
    case api, request
}

class APIError {
    private var errorCode: Int?
    private var errorMessage: String?
    private var error: Error?
    
    var type: APIErrorType = .api
    
    var isApiError: Bool {
        return type == .api
    }
    
    var code: Int? {
        if let errorCode = errorCode {
            return errorCode
        }
        return error?.errorCode
    }
    
    var message: String? {
        if let errorMessage = errorMessage {
            return errorMessage
        }
        if let error = error {
            switch error {
            case RequestErrorType.badInput:
                #if DEVELOP || STAGING
                    return "(Message in debug/staging mode) Bad input parameters"
                #endif
            case RequestErrorType.badOutput:
                #if DEVELOP || STAGING
                    return "(Message in debug/staging mode) Bad output response data"
                #endif
            case RequestErrorType.noData:
                #if DEVELOP || STAGING
                    return "(Message in debug/staging app) No data found"
                #endif
            case RequestErrorType.offline:
                return "Network is offline"
            case RequestErrorType.timeout:
                return "Request timeout"
            default:
                break
            }
        }
        return error?.localizedDescription
    }
    
    class var unknown: APIError {
        return APIError(error: RequestErrorType.unknown)
    }
    
    init(errorCode: Int? = nil,
         errorMessage: String? = nil,
         error: Error? = nil) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.error = error
        if let _ = error {
            self.type = .request
        }
    }
    
    // Depends on server-side, this method will try to parse information of error with given JSON data
    // Needs to replace this code according to server-side's JSON format
    static func tryToParseError(from json: JSON) -> APIError? {
        guard !json["error_id"].isEmpty else { return nil }
        let errorCode = json["error_id"].int
        let errorMessage = json["error_message"].string
        let error = APIError(errorCode: errorCode, errorMessage: errorMessage)
        error.type = .api
        return error
    }
}

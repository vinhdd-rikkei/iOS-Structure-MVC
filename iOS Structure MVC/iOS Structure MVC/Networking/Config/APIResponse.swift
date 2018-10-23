//
//  APIServiceResponse.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

// Define response data of requests
public enum Response {
    case json(_: JSON)
    case data(_: Data)
    case error(_: Int?, _: Error)
    
    init(_ response: DataResponse<Any>, for request: Request) {
        // Get status code
        let statusCode = response.response?.statusCode
        
        // Check if error exists
        if let error = response.result.error {
            self = .error(statusCode, error)
            return
        }
        
        // Check request data type to parse response daat
        switch request.dataType {
        case .data:
            guard let responseData = response.data else {
                self = .error(statusCode, RequestErrorType.noData)
                return
            }
            self = .data(responseData)
        case .json:
            guard let jsonData = response.result.value else {
                self = .error(statusCode, RequestErrorType.noData)
                return
            }
            let json: JSON = JSON(jsonData)
            self = .json(json)
        }
    }
}

// Model repsonse protocol based on JSON data
public protocol ModelResponseProtocol {

    // Set json as input variable
    init(json: JSON)
    
    // Action
    func printInfo()
}

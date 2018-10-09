//
//  APIServiceGeneral.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

// Define the type of repsonse data
// - json: It's a json
// - data: It's a plain data
public enum DataType {
    case json
    case data
}

// Request protocol
public protocol Request {
    var apiIdentifier: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var headers: HTTPHeaders? { get }
    var dataType: DataType { get }
}

// Define the parameters of a request
// - body: part of the body stream
// - url: as url parameters
public enum RequestParams {
    case body(_: Parameters?)
    case url(_: Parameters?)
}

// Define a list of error cases of response data
public enum NetworkErrors: Error {
    case badInput // Parameters in wrong format,...
    case badOutput // Get incorrect response data,...
    case noData // No data found
}

// TODO: - Define metal codes when request APIs (according to project)
enum ApiErrorCode: String {
    case e0001 = "E0001"
    case e0002 = "E0002"
    case e0003 = "E0003"
    var value: String { return rawValue }
}

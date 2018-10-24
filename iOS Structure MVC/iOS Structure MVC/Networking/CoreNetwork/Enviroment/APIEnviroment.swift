//
//  NetworkEnviroment.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Alamofire

public class APIEnviroment {
    
    // MARK: - Local variables
    class var `default`: APIEnviroment {
        return APIEnviroment(name: ProcessInfo.processInfo.environment["targetName"] ?? "",
                                 host: APIConstants.baseUrl,
                                 headers: APIConstants.httpHeaders,
                                 encoding: URLEncoding.default,
                                 retryTime: 1,
                                 timeout: 10)
    }

    // Name of the enviroment (default is name of current scheme)
    public var name: String = ""

    // Base URL of the enviroment (default is base url of current scheme)
    public var host: String = ""
    
    // HTTP headers of the enviroment (default is headers of current scheme)
    public var headers: HTTPHeaders = [:]
    
    // URL encoding of the enviroment (default is Encoding Default type)
    public var encoding: ParameterEncoding = URLEncoding.default
    
    // Number of retry time when request API
    public var retryTime: Int = 1
    
    // Request timeout for request
    public var timeout: TimeInterval = 10
    
    // MARK: - Init
    public init() { }
    
    public init(name: String, host: String, headers: HTTPHeaders, encoding: ParameterEncoding, retryTime: Int, timeout: TimeInterval) {
        self.name = name
        self.host = host
        self.headers = headers
        self.encoding = encoding
        self.retryTime = retryTime
        self.timeout = timeout
    }
    
    // MARK: - Builder
    @discardableResult
    public func set(name: String) -> APIEnviroment {
        self.name = name
        return self
    }
    
    @discardableResult
    public func set(host: String) -> APIEnviroment {
        self.host = host
        return self
    }
    
    @discardableResult
    public func set(headers: HTTPHeaders) -> APIEnviroment {
        self.headers = headers
        return self
    }
    
    @discardableResult
    public func set(encoding: URLEncoding) -> APIEnviroment {
        self.encoding = encoding
        return self
    }
    
    @discardableResult
    public func set(retryTime: Int) -> APIEnviroment {
        self.retryTime = retryTime
        return self
    }
    
    @discardableResult
    public func set(timeout: TimeInterval) -> APIEnviroment {
        self.timeout = timeout
        return self
    }
}

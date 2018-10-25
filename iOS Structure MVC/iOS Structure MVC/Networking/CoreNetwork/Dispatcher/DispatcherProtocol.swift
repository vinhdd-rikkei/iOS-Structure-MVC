//
//  DispatcherProtocol.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Hydra
import Alamofire

public protocol DispatcherProtocol {
    // Configure the dispatcher with an enviroment
    init(enviroment: APIEnviroment)
    
    // Execute the request
    func execute(request: RequestProtocol, retry: Int) throws -> Promise<Response>
    func cancel()
    func prepareURLRequestFor(request: RequestProtocol) -> URLRequestConvertible
}

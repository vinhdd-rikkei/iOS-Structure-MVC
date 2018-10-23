//
//  NetworkDispatcher.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Hydra
import Alamofire

class NetworkDispatcher: DispatcherProtocol {
    // Singleton variable for using default network enviroment
    static var shared = NetworkDispatcher(enviroment: APIEnviroment.default)
    
    // Request API task
    private var task: DataRequest?
    
    // Network enviroment for executing
    private var enviroment: APIEnviroment
    
    required init(enviroment: APIEnviroment) {
        self.enviroment = enviroment
    }
    
    func execute(request: Request, retry: Int) throws -> Promise<Response> {
        // Execute the request
        let urlRequest = prepareURLRequestFor(request: request)
        let op = Promise<Response>.init(in: .background, { resolve, reject, _ in
            self.task = Alamofire.request(urlRequest).responseJSON(completionHandler: { data in
                if let error = data.result.error {
                    reject(error)
                } else {
                    let response = Response(data, for: request)
                    resolve(response)
                }
            })
        })
        return op.retry(retry)
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }

    func prepareURLRequestFor(request: Request) -> URLRequestConvertible {
        return ConvertibleRequest(request: request, enviroment: enviroment)
    }
}

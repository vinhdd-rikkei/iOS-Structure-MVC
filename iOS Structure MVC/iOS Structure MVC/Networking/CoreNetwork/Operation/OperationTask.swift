//
//  OperationTask.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Hydra
import SwiftyJSON

class OperationTask<T: ModelResponseProtocol>: OperationProtocol {

    // MARK: - Typealias
    typealias Output = T
    typealias DataResponseSuccess = (_ result: Output) -> Void
    typealias DataResponseError = (_ error: APIError) -> Void
    
    // MARK: - Constants
    struct TaskData {
        var enviroment: APIEnviroment = .default
        var responseQueue: DispatchQueue = .main
        var showIndicator: Bool = true
        var autoShowApiErrorAlert = true
        var autoShowRequestErrorAlert = true
        var successHandler: DataResponseSuccess? = nil
        var errorHandler: DataResponseError? = nil
        init() { }
    }
    
    // MARK: - Variables
    private var taskData = TaskData()
    
    final var code: String {
        return request?.apiIdentifier ?? "--"
    }
    
    var request: Request?
    
    // MARK: - Init
    init(request: Request) {
        self.request = request
    }
    
    // MARK: - Builder
    @discardableResult
    func set(enviroment: APIEnviroment) -> OperationTask<Output> {
        taskData.enviroment = enviroment
        return self
    }
    
    @discardableResult
    func set(responseQueue: DispatchQueue) -> OperationTask<Output> {
        taskData.responseQueue = responseQueue
        return self
    }
    
    @discardableResult
    // Load request without: showing indicator + showing api error alert + request error alert automatically
    func set(silentLoad: Bool) -> OperationTask<Output> {
        taskData.showIndicator = !silentLoad
        taskData.autoShowApiErrorAlert = !silentLoad
        taskData.autoShowRequestErrorAlert = !silentLoad
        return self
    }
    
    @discardableResult
    func showIndicator(_ show: Bool) -> OperationTask<Output> {
        taskData.showIndicator = show
        return self
    }
    
    @discardableResult
    func autoShowApiErrorAlert(_ show: Bool) -> OperationTask<Output> {
        taskData.autoShowApiErrorAlert = show
        return self
    }
    
    @discardableResult
    func autoShowRequestErrorAlert(_ show: Bool) -> OperationTask<Output> {
        taskData.autoShowRequestErrorAlert = show
        return self
    }
    
    // MARK: - Executing functions
    func execute(success: DataResponseSuccess? = nil,
                 error: DataResponseError? = nil) {
        func run(queue: DispatchQueue?, body: @escaping () -> Void) {
            (queue ?? .main).async {
                body()
            }
        }
        taskData.successHandler = success
        taskData.errorHandler = error
        let dispatcher = NetworkDispatcher(enviroment: taskData.enviroment)
        let retry = taskData.enviroment.retryTime
        let showIndicator = taskData.showIndicator
        let responseQueue = taskData.responseQueue
        if let request = self.request {
            do {
                if showIndicator {
                    run(queue: .main) { NetworkIndicator.show() }
                }
                try dispatcher.execute(request: request, retry: retry).then({ response in
                    self.parse(response: response, completion: { output, error in
                        print("-> [\(request.apiIdentifier)] Requested successfully !!")
                        if showIndicator {
                            run(queue: .main) { NetworkIndicator.hide() }
                        }
                        run(queue: responseQueue) {
                            if let output = output {
                                self.callbackSuccess(output: output)
                            } else if let error = error {
                                self.callbackError(error: error)
                            } else {
                                self.callbackError(error: APIError(error: RequestErrorType.unknown))
                            }
                        }
                    })
                }).catch { error in
                    if showIndicator {
                        run(queue: .main) { NetworkIndicator.hide() }
                    }
                    run(queue: responseQueue) {
                        self.callbackError(error: APIError(error: error))
                    }
                }
            } catch {
                if showIndicator {
                    run(queue: .main) { NetworkIndicator.hide() }
                }
                run(queue: responseQueue) {
                    self.callbackError(error: APIError(error: error))
                }
            }
        } else {
            run(queue: responseQueue) {
                self.callbackError(error: APIError(error: RequestErrorType.badInput))
            }
        }
    }
    
    func cancel(with dispatcher: DispatcherProtocol? = nil) {
        (dispatcher ?? NetworkDispatcher.shared).cancel()
    }
    
    private func parse(response: Response, completion: @escaping ((_ output: T?, _ error: APIError?) -> Void)) {
        var getJson: JSON?
        switch response {
        case .json(let json):
            getJson = json
        case .data(let data):
            do {
                let json = try JSON(data: data)
                getJson = json
            } catch {
                completion(nil, APIError(error: error))
            }
        case .error(_, let error):
            completion(nil, APIError(error: error))
        }
        
        guard let json = getJson else {
            completion(nil, APIError(error: RequestErrorType.badOutput))
            return
        }
        
        guard let error = APIError.tryToParseError(from: json) else {
            completion(T(json: json), nil)
            return
        }
        completion(nil, error)
    }
    
    private func callbackSuccess(output: T) {
        output.printInfo()
        taskData.successHandler?(output)
    }
    
    private func callbackError(error: APIError) {
        showErrorAlertIfNeeded(error: error)
        taskData.errorHandler?(error)
    }
    
    // MARK: - Alerts
    private func showErrorAlertIfNeeded(error: APIError) {
        if error.isApiError && taskData.autoShowApiErrorAlert {
            // TODO: - Show api error alert automatically
        }
        if !error.isApiError && taskData.autoShowRequestErrorAlert {
            // TODO: - Show request error alert automatically
        }
    }
}

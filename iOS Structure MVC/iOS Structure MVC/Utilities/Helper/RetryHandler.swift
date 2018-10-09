//
//  RetryHandler.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//
import UIKit

typealias RetryHandlerExecute = ((_ controller: RetryHandler) -> Void)
typealias RetryHandlerFinished = ((_ controller: RetryHandler) -> Void)

class RetryHandler {
    var count: Int
    var executeClosure: RetryHandlerExecute?
    var finishedClosure: RetryHandlerFinished?
    
    init(count: Int) {
        self.count = count >= 0 ? count : 0
    }
    
    @discardableResult
    func tryTo(handler: RetryHandlerExecute?) -> RetryHandler {
        executeClosure = handler
        handler?(self)
        return self
    }
    
    @discardableResult
    func finished(handler: RetryHandlerFinished?) -> RetryHandler {
        finishedClosure = handler
        return self
    }
    
    func retry() {
        count -= 1
        if count < 0 {
            finishedClosure?(self)
        } else {
            executeClosure?(self)
        }
    }
}

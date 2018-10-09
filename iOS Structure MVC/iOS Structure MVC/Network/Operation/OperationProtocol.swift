//
//  OperationProtocol.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Hydra

protocol OperationProtocol {
    // Define Output type that should returns
    associatedtype Output
    
    // APi code
    var code: String { get }
    
    // Request
    var request: Request? { get }
}

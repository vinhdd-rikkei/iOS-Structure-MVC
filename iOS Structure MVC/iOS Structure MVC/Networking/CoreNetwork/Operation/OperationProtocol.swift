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
    // API id
    var id: String { get }
    
    // Request
    var request: RequestProtocol? { set get }
}

//
//  LoginAPI.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import SwiftyJSON

class AnswerListAPIResponse: ModelResponseProtocol {
    
    var answerList: [Answer] = []
    
    required init(json: JSON) {
        // Parse json data from server to local variables
        answerList = json["items"].arrayValue.map({ Answer.init(json: $0) })
    }
}

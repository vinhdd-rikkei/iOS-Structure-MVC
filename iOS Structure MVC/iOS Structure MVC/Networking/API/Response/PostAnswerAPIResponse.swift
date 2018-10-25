//
//  PostAnswerAPIResponse.swift
//  iOS Structure MVC
//
//  Created by Vinh Dang on 10/26/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import SwiftyJSON

class PostAnswerAPIResponse: ModelResponseProtocol {
    
    var success: Bool?
    
    required init(json: JSON) {
        // Parse json data from server to local variables
        success = json["success"].bool
    }
}

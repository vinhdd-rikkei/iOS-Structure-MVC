//
//  EnumType.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

// General enum list
enum RandomStringType: String {
    case numericDigits = "0123456789"
    case uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    case lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
    case allKindLetters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    case numericDigitsAndLetters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    var text: String { return rawValue }
}

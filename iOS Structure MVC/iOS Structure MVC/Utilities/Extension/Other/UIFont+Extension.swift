//
//  UIFont+Extension.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

// MARK: - Font family is only used in this app
extension UIFont {
    static func fontNormal(size: CGFloat) -> UIFont {
        return UIFont(name: "YuGothic-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func fontBold(size: CGFloat) -> UIFont {
        return UIFont(name: "YuGothic-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}

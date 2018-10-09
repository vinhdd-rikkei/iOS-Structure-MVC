//
//  BorderTextField.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class BorderTextFeild: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var paddingLeft: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRight: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
    override func draw(_ rect: CGRect) {
        clipsToBounds = true
        layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}

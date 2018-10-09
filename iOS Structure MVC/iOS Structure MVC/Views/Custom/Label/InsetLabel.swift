//
//  InsetLabel.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

@IBDesignable class InsetLabel: UILabel {
    
    @IBInspectable var insetTop: CGFloat = 5.0
    @IBInspectable var insetBottom: CGFloat = 5.0
    @IBInspectable var insetLeft: CGFloat = 7.0
    @IBInspectable var insetRight: CGFloat = 7.0
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: insetTop, left: insetLeft, bottom: insetBottom, right: insetRight)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += insetTop + insetBottom
        intrinsicSuperViewContentSize.width += insetLeft + insetRight
        return intrinsicSuperViewContentSize
    }
}

//
//  UITextView+Extension.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

extension UITextView {
    public func sizeFit(width: CGFloat) -> CGSize {
        let fixedWidth = width
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude))
        return CGSize(width: fixedWidth, height: newSize.height)
    }
    
    public func sizeFit(height: CGFloat) -> CGSize {
        let fixedHeight = height
        let newSize = self.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: fixedHeight))
        return CGSize(width: newSize.width, height: fixedHeight)
    }
    
    public func underline() {
        if let text = self.text {
            let textRange = NSRange(location: 0, length: text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
            self.attributedText = attributedText
        }
    }
}

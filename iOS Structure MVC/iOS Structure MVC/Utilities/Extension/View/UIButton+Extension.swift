//
//  UIButton+Extension.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

extension UIButton {
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedTitle(for: .normal) {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
                setTitle(.none, for: .normal)
            }
            attributedString.addAttribute(.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            setAttributedTitle(attributedString, for: .normal)
        }
        get {
            if let currentLetterSpace = attributedTitle(for: .normal)?.attribute(.kern,
                                                                                 at: 0,
                                                                                 effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            return 0
        }
    }
    
    func alignVertical(spacing: CGFloat = 6.0) {
        let buttonSize = frame.size
        if let titleLabel = titleLabel, let imageView = imageView {
            if let buttonTitle = titleLabel.text, let image = imageView.image {
                let titleString: NSString = NSString(string: buttonTitle)
                let titleSize = titleString.size(withAttributes: [.font: titleLabel.font])
                let buttonImageSize = image.size
                let topImageOffset = (buttonSize.height - (titleSize.height + buttonImageSize.height + spacing)) / 2
                let leftImageOffset = (buttonSize.width - buttonImageSize.width) / 2
                imageEdgeInsets = UIEdgeInsets(top: topImageOffset, left: leftImageOffset, bottom: 0, right: 0)
                let topTitleOffset = topImageOffset + spacing + buttonImageSize.height
                let leftTitleOffset = (buttonSize.width - titleSize.width) / 2 - image.size.width
                titleEdgeInsets = UIEdgeInsets(top: topTitleOffset, left: leftTitleOffset, bottom: 0, right: 0)
            }
        }
    }
    
    func setNormalButton(borderCorlor: UIColor, bgColor: UIColor){
        self.layer.borderColor = borderCorlor.cgColor
        self.layer.borderWidth = 1.0
        self.backgroundColor = bgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.setTitleColor(borderCorlor, for: .normal)
        
    }
    func setSelectedButon(bgColor : UIColor){
        self.backgroundColor = bgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func setTextUnderline(text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

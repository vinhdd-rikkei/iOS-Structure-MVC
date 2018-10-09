//
//  ColorImageView.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

@IBDesignable class ColorImageView: UIImageView {

    @IBInspectable var color: UIColor = .white
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        image = image?.renderTemplate()
        tintColor = color
    }
}

//
//  CheckBox.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

@IBDesignable
class CheckBox: UIButton {
    // Images
    @IBInspectable var checkedImage : UIImage?
    @IBInspectable var uncheckedImage : UIImage?
    
    // Bool property
     @IBInspectable var isChecked: Bool = false {
        didSet{
            let image = isChecked ? checkedImage : uncheckedImage
            self.setBackgroundImage(image, for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}

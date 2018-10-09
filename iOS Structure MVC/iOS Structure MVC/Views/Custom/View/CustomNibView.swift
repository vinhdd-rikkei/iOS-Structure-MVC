//
//  CustomNibView.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class CustomNibView: UIView {

    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    
    // MARK: - Variables
    var xibName: String? { return nil }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup
    func setup() {
        let fullName = NSStringFromClass(type(of: self))
        let xibName = self.xibName == nil ? fullName.components(separatedBy: ".").last : self.xibName
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed(xibName!, owner: self, options: nil)
        addSubview(contentView)
        frame.size = contentView.frame.size
        AutoLayoutHelper.fit(contentView, superView: self)
        backgroundColor = .clear
    }
}

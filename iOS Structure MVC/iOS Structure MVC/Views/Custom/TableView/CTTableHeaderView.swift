//
//  CTTableHeaderView.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class CTTableHeaderView: CTBaseCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Builder
    @discardableResult
    func set(text: String?) -> CTTableHeaderView {
        titleLabel.text = text
        return self
    }
}

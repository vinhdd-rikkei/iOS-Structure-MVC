//
//  CTCheckmarkCell.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class CTCheckmarkCell: CTBaseCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!

    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Builder
    @discardableResult
    func set(title: String?, isChecked: Bool) -> CTCheckmarkCell {
        titleLabel.text = title
        checkmarkImageView.isHidden = !isChecked
        return self
    }
}

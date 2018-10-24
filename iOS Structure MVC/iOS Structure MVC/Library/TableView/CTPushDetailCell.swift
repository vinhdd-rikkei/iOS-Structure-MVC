//
//  CTPushDetailCell.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class CTPushDetailCell: CTBaseCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    // MARK: - Constraints
    @IBOutlet weak var arrowImageViewWidthZeroConstraint: NSLayoutConstraint!
    @IBOutlet weak var arrowImageViewRightZeroConstraint: NSLayoutConstraint!
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Builder
    @discardableResult
    func set(title: String?, value: String?) -> CTPushDetailCell {
        titleLabel.text = title
        valueLabel.text = value
        return self
    }
    
    // MARK: - Update UI
    func togglePushIcon(show: Bool) {
        arrowImageView.isHidden = !show
        arrowImageViewWidthZeroConstraint.priority = show ? AutoLayoutHelper.lowestPriority : AutoLayoutHelper.highestPriority
        arrowImageViewRightZeroConstraint.priority = show ? AutoLayoutHelper.lowestPriority : AutoLayoutHelper.highestPriority
    }
}

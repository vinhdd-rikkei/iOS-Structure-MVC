//
//  CTSwitchCell.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class CTSwitchCell: CTBaseCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    // MARK: - Closures
    var didSwitch: ((_ isOn: Bool) -> Void)?
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Actions
    @IBAction func switchButtonAction(_ sender: UISwitch) {
        didSwitch?(sender.isOn)
    }
    
    // MARK: - Builder
    @discardableResult
    func set(title: String?, isOn: Bool) -> CTSwitchCell {
        titleLabel.text = title
        switchButton.isOn = isOn
        return self
    }
}

//
//  CTBaseCell.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//
import UIKit

class CTBaseCell: UITableViewCell {
    
    // MARK: - Outlets
    weak var underlineView: UIView?
    var underlineViewLeftHighConstraint: NSLayoutConstraint?

    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        createUnderline()
    }
    
    private func createUnderline() {
        guard underlineView == nil else { return }
        
        // Create underline view
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hexa: "#576DA1")
        addSubview(lineView)
        
        // Add constraints
        let insets = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 0)
        let height: CGFloat = 1
        let leftHighConstraint = AutoLayoutHelper.equalConstraint(lineView, superView: self, attribute: .left, constant: 0)
        leftHighConstraint.priority = .defaultHigh
        let leftLowConstraint = AutoLayoutHelper.equalConstraint(lineView, superView: self, attribute: .left, constant: insets.left)
        leftLowConstraint.priority = .defaultLow
        let rightConstraint = AutoLayoutHelper.equalConstraint(lineView, superView: self, attribute: .right, constant: insets.right)
        let bottomConstraint = AutoLayoutHelper.equalConstraint(lineView, superView: self, attribute: .bottom, constant: insets.bottom)
        let heightConstraint = AutoLayoutHelper.fixedConstraint(lineView, attribute: .height, value: height)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([leftHighConstraint, leftLowConstraint, rightConstraint, bottomConstraint, heightConstraint])
        
        // Parse variables
        underlineView = lineView
        underlineViewLeftHighConstraint = leftHighConstraint
    }
    
    // MARK: - Builder
    @discardableResult
    func showUnderline() -> CTBaseCell {
        underlineView?.isHidden = false
        return self
    }
    
    @discardableResult
    func hideUnderline() -> CTBaseCell {
        underlineView?.isHidden = true
        return self
    }
    
    @discardableResult
    func shortUnderline(_ isShort: Bool) -> CTBaseCell {
        underlineViewLeftHighConstraint?.isActive = !isShort
        return self
    }
    
    @discardableResult
    func setSelectedBackgroundColor(_ color: UIColor) -> CTBaseCell {
        let bgView = UIView()
        bgView.backgroundColor = color
        selectedBackgroundView = bgView
        return self
    }
}

//
//  RoundedView.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    // MARK: - Inspectables
    @IBInspectable var fillColor: UIColor = .white
    @IBInspectable var cornerTopLeft: Bool = true
    @IBInspectable var cornerTopRight: Bool = true
    @IBInspectable var cornerBottomLeft: Bool = true
    @IBInspectable var cornerBottomRight: Bool = true
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        layer.masksToBounds = false
        backgroundColor = .clear
    }
    
    // MARK: - Drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        var cornerList = UIRectCorner()
        if cornerTopLeft { cornerList.insert(.topLeft) }
        if cornerTopRight { cornerList.insert(.topRight) }
        if cornerBottomLeft { cornerList.insert(.bottomLeft) }
        if cornerBottomRight { cornerList.insert(.bottomRight) }
        let roundedPath = UIBezierPath(roundedRect: CGRect(x: borderWidth / 2, y: borderWidth / 2, width: rect.width - borderWidth, height: rect.height - borderWidth), byRoundingCorners: cornerList, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        if !cornerTopLeft {
            roundedPath.move(to: CGPoint(x: 0, y: borderWidth / 2))
            roundedPath.addLine(to: CGPoint(x: borderWidth / 2, y: borderWidth / 2))
        }
        roundedPath.lineWidth = borderWidth
        borderColor.setStroke()
        roundedPath.stroke()
        fillColor.setFill()
        roundedPath.fill()
        roundedPath.addClip()
        roundedPath.close()
    }
}

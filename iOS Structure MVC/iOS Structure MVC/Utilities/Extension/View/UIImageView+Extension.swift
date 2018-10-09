//
//  UIImageView+Extension.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: URL?,
                   placeholder: UIImage? = nil,
                   showIndicator: Bool = false,
                   forceRefresh: Bool = false,
                   completion: ((_ image: UIImage?, _ error: Error?, _ url: URL?) -> Void)? = nil) {
        if showIndicator {
            self.kf.indicator?.startAnimatingView()
        }
        var options: KingfisherOptionsInfo = [.transition(.fade(0.2))]
        if forceRefresh {
            options.append(.forceRefresh)
        }
        self.kf.setImage(with: url, placeholder: placeholder, options: options, progressBlock: nil) { [weak self] (image, error, _, url) in
            if showIndicator {
                self?.kf.indicator?.stopAnimatingView()
            }
            completion?(image, error, url)
        }
    }
    
    func set(color: UIColor) {
        image = image?.renderTemplate()
        tintColor = color
    }
    
    func renderOriginal() {
        image = image?.renderOriginal()
    }
    
    func renderTemplate() {
        image = image?.renderTemplate()
    }
    
    func roundRectWith(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        shape.backgroundColor = UIColor.red.cgColor
        self.layer.mask = shape
    }
    
    func roundCornersForAspectFit(radius: CGFloat) {
        if let image = self.image {
            let boundsScale = self.bounds.size.width / self.bounds.size.height
            let imageScale = image.size.width / image.size.height
            var drawingRect: CGRect = self.bounds
            if boundsScale > imageScale {
                drawingRect.size.width =  drawingRect.size.height * imageScale
                drawingRect.origin.x = (self.bounds.size.width - drawingRect.size.width) / 2
            } else {
                drawingRect.size.height = drawingRect.size.width / imageScale
                drawingRect.origin.y = (self.bounds.size.height - drawingRect.size.height) / 2
            }
            let path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

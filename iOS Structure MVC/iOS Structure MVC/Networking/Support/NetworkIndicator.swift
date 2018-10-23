//
//  NetworkIndicator.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import MBProgressHUD

class NetworkIndicator {
    static func show(atView view: UIView? = nil,
                     showDimBackground: Bool = true,
                     canInteractBehind: Bool = true) {
        let viewToShow = view ?? UIApplication.shared.windows.first ?? nil
        guard let showView = viewToShow else { return }
        let progressView = MBProgressHUD.showAdded(to: showView, animated: true)
        if showDimBackground {
            progressView.backgroundView.style = .solidColor
            progressView.backgroundView.color = UIColor.black.withAlphaComponent(0.5)
        }
        progressView.removeFromSuperViewOnHide = true
        progressView.isUserInteractionEnabled = canInteractBehind
    }
    
    static func hide(atView view: UIView? = nil, animated: Bool = true) {
        let viewToHide = view ?? UIApplication.shared.windows.first ?? nil
        guard let hideView = viewToHide else { return }
        MBProgressHUD.hide(for: hideView, animated: animated)
    }
}

//
//  BaseVC.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    // MARK: - Init & deinit
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfig()
    }

    // MARK: - Setup
    private func baseConfig() {
        edgesForExtendedLayout = []
    }
}

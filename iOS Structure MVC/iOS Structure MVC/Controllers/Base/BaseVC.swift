//
//  BaseVC.swift
//  Hemophilia_iOS
//
//  Created by vinhdd on 8/10/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
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

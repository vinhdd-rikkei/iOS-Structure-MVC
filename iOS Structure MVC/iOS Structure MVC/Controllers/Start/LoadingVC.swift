//
//  LoadingVC.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class LoadingVC: BaseVC {

    // MARK: - Outlets
    
    // MARK: - Constraints
    
    // MARK: - Constants
    
    // MARK: - Variables
    
    // MARK: - Closures
    
    // MARK: - Init & deinit
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        requestApi()
    }
    
    // MARK: - Setup
    private func setupView() {
        // Do nothing
    }
    
    private func requestApi() {
        let request = AnswerRequest.getAnswerList(order: "desc",
                                                  sort: "activity",
                                                  site: "stackoverflow")
        AnswerListAPI(request: request).execute(success: { response in
            print("Got list: \(response.answerList.count) elements")
        }, error: { error in
            print("Got error: \(error.message ?? "-")")
        })
    }
    
    // MARK: - Data management
    
    // MARK: - Action
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods

}

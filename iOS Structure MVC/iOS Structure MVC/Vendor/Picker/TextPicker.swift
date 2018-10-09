//
//  TextPicker.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

typealias TextPickerResponse = (index: Int, stringValue: String)

class TextPicker: BasePicker {
    
    // MARK: - Outlets
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Constraints
    @IBOutlet var containerViewZeroHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    fileprivate var list = [String]()
    fileprivate var defaultIndex = 0
    var doneString: String?
    
    // MARK: - Closures
    var didScrollToRow: ((TextPickerResponse?) -> Void)?
    var didSelectText: ((TextPickerResponse?) -> Void)?
    
    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPickerView()
        setupGestureRecognizers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showWithAnimation()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .clear
        view.isOpaque = false
        containerViewZeroHeightConstraint.priority = AutoLayoutHelper.highestPriority
        
        // Config animation
        configWhenShow = { [weak self] in
            self?.containerViewZeroHeightConstraint.priority = AutoLayoutHelper.lowestPriority
            self?.dimView.alpha = 0.5
        }
        configWhenHide = { [weak self] in
            self?.containerViewZeroHeightConstraint.priority = AutoLayoutHelper.highestPriority
            self?.dimView.alpha = 0
        }
        if let doneStr = self.doneString {
            doneButton.setTitle(doneStr, for: .normal)
        }
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        if defaultIndex < list.count {
            pickerView.selectRow(defaultIndex, inComponent: 0, animated: false)
        }
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(gesture:)))
        dimView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @IBAction func doneBction(_ sender: UIButton) {
        let index = pickerView.selectedRow(inComponent: 0)
        guard index < list.count else { return }
        let value = list[index]
        hideWithAnimation(completion: { [weak self] in
            self?.dismiss(animated: false, completion: { [weak self] in
                self?.didSelectText?((index: index, stringValue: value))
            })
        })
    }
    
    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        hideWithAnimation(completion: { [weak self] in
            self?.dismiss(animated: false, completion: { [weak self] in
                self?.didSelectText?(nil)
            })
        })
    }
    
    @objc func tapGestureAction(gesture: UITapGestureRecognizer) {
        hideWithAnimation(completion: { [weak self] in
            self?.dismiss(animated: false, completion: { [weak self] in
                self?.didSelectText?(nil)
            })
        })
    }
    
    // MARK: - Data management
    func set(list: [String], defaultIndex: Int = 0) {
        self.list = list
        self.defaultIndex = defaultIndex
    }
}

extension TextPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
}

extension TextPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didScrollToRow?((index: row, stringValue: list[row]))
    }
}

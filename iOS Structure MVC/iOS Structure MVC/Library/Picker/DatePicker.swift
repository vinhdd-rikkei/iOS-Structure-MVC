//
//  DatePicker.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

typealias DatePickerResponse = (date: Date, day: Int, month: Int, year: Int)
typealias TimePickerResponse = (hour: Int, minute: Int)

enum DatePickerType {
    case date, time
}

class DatePicker: BasePicker {
    
    // MARK: - Outlets
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Constraints
    @IBOutlet var hideViewConstraint: NSLayoutConstraint!
 
    // MARK: - Variables
    fileprivate var selectedDate: Date = Date()
    fileprivate var minDate: Date?
    fileprivate var maxDate: Date?
    
    // MARK: - Shared variables
    var pickerType: DatePickerType = .date
    
    // MARK: - Closure
    var didSelectDate: ((DatePickerResponse?) -> Void)?
    var didSelectTime: ((TimePickerResponse?) -> Void)?
    
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
        pickerType == .date ? setupDatePicker() : setupTimePicker()
        setupGestureRecognizers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showWithAnimation()
    }
    
    // MARK: - Setup
    private func setupView() {
        //UI
        view.backgroundColor = .clear
        view.isOpaque = false

        // Config animation
        configWhenShow = { [weak self] in
            self?.hideViewConstraint.isActive = false
            self?.dimView.alpha = 0.5
        }
        configWhenHide = { [weak self] in
            self?.hideViewConstraint.isActive = true
            self?.dimView.alpha = 0
        }
    }
    
    private func setupDatePicker() {
        datePicker.calendar = AppConstants.calendar
        datePicker.datePickerMode = .date
        datePicker.setDate(selectedDate, animated: true)
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
    private func setupTimePicker(){
        datePicker.calendar = AppConstants.calendar
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "en_GB") // Fixed to display hour format from 0 to 23
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(gesture:)))
        dimView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @IBAction func doneButtonAction(_ sender: UIButton) {
        let component = selectedDate.getComponents()
        if pickerType == .date {
            guard let day = component.day, let month = component.month, let year = component.year else { return }
            hideWithAnimation(completion: { [weak self] in
                guard let sSelf = self else { return }
                sSelf.dismiss(animated: false, completion: { [weak sSelf] in
                    sSelf?.didSelectDate?((date: sSelf?.selectedDate ?? Date(), day: day, month: month, year: year))
                })
            })
        }
        else{
            guard let hour = component.hour, let minute = component.minute else { return }
            hideWithAnimation(completion: { [weak self] in
                guard let sSelf = self else { return }
                sSelf.dismiss(animated: false, completion: { [weak sSelf] in
                    sSelf?.didSelectTime?((hour: hour, minute: minute))
                })
            })
        }
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    @objc func tapGestureAction(gesture: UITapGestureRecognizer) {
        hideWithAnimation(completion: { [weak self] in
            self?.dismiss(animated: false, completion: { [weak self] in
                self?.didSelectDate?(nil)
            })
        })
    }
    
    // MARK: - Data management
    func set(day: Int, month: Int, year: Int, minDate: Date? = nil, maxDate: Date? = nil) {
        self.selectedDate = Date(year: year, month: month, day: day)
        self.minDate = minDate
        self.maxDate = maxDate
    }
    
    func set(date: Date, minDate: Date? = nil, maxDate: Date? = nil) {
        self.selectedDate = date
        self.minDate = minDate
        self.maxDate = maxDate
    }
}

//
//  PickerViewer.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class PickerViewer {
    static func showTextPicker(list: [String],
                               defaultIndex: Int = 0,
                               doneStringButton: String = "ok".localized,
                               completion: ((TextPickerResponse?) -> Void)?) {
        ViewControllerTask.present(type: TextPicker.self, prepare: { picker in
            picker.set(list: list, defaultIndex: defaultIndex)
            picker.doneString = doneStringButton
            picker.didSelectText = { response in
                completion?(response)
            }
        }, animated: false)
    }

    static func showDatePicker(day: Int, month: Int, year: Int, minDate: Date? = nil, maxDate: Date? = nil, completion: ((DatePickerResponse?) -> Void)?) {
        ViewControllerTask.present(type: DatePicker.self, prepare: { picker in
            picker.set(day: day, month: month, year: year, minDate: minDate, maxDate: maxDate)
            picker.didSelectDate = { response in
                completion?(response)
            }
        }, animated: false)
    }
    
    static func showDatePicker(date: Date, minDate: Date? = nil, maxDate: Date? = nil, completion: ((DatePickerResponse?) -> Void)?) {
        ViewControllerTask.present(type: DatePicker.self, prepare: { picker in
            picker.set(date: date, minDate: minDate, maxDate: maxDate)
            picker.didSelectDate = { response in
                completion?(response)
            }
        }, animated: false)
    }
    
    static func showTimePicker(completion: ((TimePickerResponse?) -> Void)?){
        ViewControllerTask.present(type: DatePicker.self, prepare: { (picker) in
            picker.pickerType = .time
            picker.didSelectTime = { response in
                completion?(response)
            }
        }, animated: false){}
    }
    
   
}

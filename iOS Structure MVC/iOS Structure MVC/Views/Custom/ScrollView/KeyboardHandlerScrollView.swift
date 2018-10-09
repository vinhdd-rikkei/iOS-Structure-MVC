//
//  KeyboardHandlerScrollView.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

typealias KeyboardFrameResponse = ((_ frame: CGRect) -> Void)
enum KeyboardPresenterStates {
    case willShow, didShow, willHide, didHide
}

class KeyboardHandlerScrollView: UIScrollView {
    
    // MARK: - Variables
    private var changeInsetsWhenKeyboardWillShow = true {
        didSet { if changeInsetsWhenKeyboardDidShow == changeInsetsWhenKeyboardWillShow { changeInsetsWhenKeyboardDidShow = !changeInsetsWhenKeyboardWillShow } }
    }
    private var changeInsetsWhenKeyboardDidShow = true {
        didSet { if changeInsetsWhenKeyboardWillShow == changeInsetsWhenKeyboardDidShow { changeInsetsWhenKeyboardWillShow = !changeInsetsWhenKeyboardDidShow } }
    }
    private var changeInsetsWhenKeyboardWillHide = true {
        didSet { if changeInsetsWhenKeyboardDidHide == changeInsetsWhenKeyboardWillHide { changeInsetsWhenKeyboardDidHide = !changeInsetsWhenKeyboardWillHide } }
    }
    private var changeInsetsWhenKeyboardDidHide = true {
        didSet { if changeInsetsWhenKeyboardWillHide == changeInsetsWhenKeyboardDidHide { changeInsetsWhenKeyboardWillHide = !changeInsetsWhenKeyboardDidHide } }
    }
    var tapToEndEditing = true
    
    // MARK: - Closure
    var keyboardWillShow: KeyboardFrameResponse?
    var keyboardDidShow: KeyboardFrameResponse?
    var keyboardWillHide: KeyboardFrameResponse?
    var keyboardDidHide: KeyboardFrameResponse?
    
    
    // MARK: - Init & deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Builder
    @discardableResult
    func willShow(handler: @escaping KeyboardFrameResponse) -> KeyboardHandlerScrollView {
        keyboardWillShow = handler
        return self
    }
    
    @discardableResult
    func didShow(handler: @escaping KeyboardFrameResponse) -> KeyboardHandlerScrollView {
        keyboardDidShow = handler
        return self
    }
    
    @discardableResult
    func willHide(handler: @escaping KeyboardFrameResponse) -> KeyboardHandlerScrollView {
        keyboardWillHide = handler
        return self
    }
    
    @discardableResult
    func didHide(handler: @escaping KeyboardFrameResponse) -> KeyboardHandlerScrollView {
        keyboardDidHide = handler
        return self
    }
    
    @discardableResult
    func changeInsetsWhen(show: KeyboardPresenterStates, andHide hide: KeyboardPresenterStates) -> KeyboardHandlerScrollView {
        changeInsetsWhenKeyboardWillShow = show == .willShow
        changeInsetsWhenKeyboardWillHide = hide == .willHide
        return self
    }
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        detectKeyboardStates()
        setupGestures()
    }
    
    private func setupGestures() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollViewTapGesture(sender:))))
    }
    
    // MARK: - Action
    func detectKeyboardStates() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { [weak self] noti in
            guard let sSelf = self, sSelf.changeInsetsWhenKeyboardWillShow else { return }
            let keyboardRect = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
            sSelf.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height, right: 0)
            sSelf.keyboardWillShow?(keyboardRect)
        })
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: nil, using: { [weak self] noti in
            guard let sSelf = self, sSelf.changeInsetsWhenKeyboardDidShow else { return }
            let keyboardRect = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
            sSelf.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height, right: 0)
            sSelf.keyboardDidShow?(keyboardRect)
        })
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { [weak self] noti in
            guard let sSelf = self, sSelf.changeInsetsWhenKeyboardWillHide else { return }
            let keyboardRect = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
            sSelf.contentInset = UIEdgeInsets.zero
            sSelf.keyboardWillHide?(keyboardRect)
        })
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: nil, using: { [weak self] noti in
            guard let sSelf = self, sSelf.changeInsetsWhenKeyboardDidHide else { return }
            let keyboardRect = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
            sSelf.contentInset = UIEdgeInsets.zero
            sSelf.keyboardDidHide?(keyboardRect)
        })
    }
    
    @objc private func scrollViewTapGesture(sender: UITapGestureRecognizer) {
        if tapToEndEditing { endEditing(true) }
    }
}

//
//  ViewControllerTask.swift
//  Hemophilia_iOS
//
//  Created by vinhdd on 8/10/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit

class ViewControllerTask {
    static func type<T: UIViewController>(_ type: T.Type) -> T {
        let nibName = ViewControllerTask.getNameFor(type: type)
        let vc = T(nibName: nibName, bundle: nil)
        return vc
        
    }
    
    static func getNameFor<T: UIViewController>(type: T.Type) -> String {
        let typeName = NSStringFromClass(type)
        let returnName = typeName.split { $0 == "." }.map { String($0) }.last ?? typeName
        return returnName
    }
    
    static func present<T: UIViewController>(type: T.Type,
                                             fromController: UIViewController? = nil,
                                             prepare: ((_ vc: T) -> Void)? = nil,
                                             animated: Bool = true,
                                             completion: (() -> Void)? = nil) {
        let vc = ViewControllerTask.type(type)
        vc.modalTransitionStyle = .crossDissolve
        prepare?(vc)
        let parentVC = fromController ?? UIViewController.topViewController()
        parentVC?.present(vc, animated: animated, completion: completion)
    }
    
    static func present(controller: UIViewController,
                        fromController: UIViewController? = nil,
                        prepare: ((_ vc: UIViewController) -> Void)? = nil,
                        animated: Bool = true,
                        completion: (() -> Void)? = nil) {
        controller.modalTransitionStyle = .crossDissolve
        prepare?(controller)
        let parentVC = fromController ?? UIViewController.topViewController()
        parentVC?.present(controller, animated: animated, completion: completion)
    }
    
    static func push<T: UIViewController>(type: T.Type,
                                          fromController: UIViewController? = nil,
                                          prepare: ((_ vc: T) -> Void)? = nil,
                                          animated: Bool = true,
                                          completion: (() -> Void)? = nil) {
        let vc = ViewControllerTask.type(type)
        prepare?(vc)
        let parentVC = fromController ?? UIViewController.topViewController()
        parentVC?.navigationController?.pushViewController(vc, animated: animated)
        completion?()
    }
    
    static func push(controller: UIViewController,
                     fromController: UIViewController? = nil,
                     prepare: ((_ vc: UIViewController) -> Void)? = nil,
                     animated: Bool = true,
                     completion: (() -> Void)? = nil) {
        prepare?(controller)
        let parentVC = fromController ?? UIViewController.topViewController()
        parentVC?.navigationController?.pushViewController(controller, animated: animated)
        completion?()
    }
    
    static func dismiss(controller: UIViewController? = UIViewController.topViewController(), animated: Bool = true, completion: (() -> Void)? = nil) {
        if let _ = controller?.presentingViewController {
            controller?.dismiss(animated: animated, completion: completion)
        } else {
            completion?()
        }
    }
    
    static func pop(controller: UIViewController? = UIViewController.topViewController(), animated: Bool = true, toRoot: Bool = false) {
        if !toRoot {
            controller?.navigationController?.popViewController(animated: animated)
        } else {
            controller?.navigationController?.popToRootViewController(animated: animated)
        }
    }
}

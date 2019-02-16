//
//  UITextField+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UITextField {
    
    fileprivate struct AssociatedKeys {
        static var date = "date"
    }
    
    fileprivate var date: BehaviorRelay<Date?>? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.date) as? BehaviorRelay<Date?>
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.date, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
}

//
//  UIView+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

extension UIView {
    
    static var viewFromNib: UIView? {
        return nib.instantiate(withOwner: nil, options: nil).first as? UIView
    }
    
    static var identifier: String {
        return String(describing: self.classForCoder())
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBInspectable
    var asCircle: Bool {
        get {
            return layer.cornerRadius == frame.height / 2.0 && layer.masksToBounds
        }
        set {
            isHidden = true
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100), execute: { [weak self] in
                self?.isHidden = false
                self?.layer.cornerRadius = (self?.frame.height ?? 0.0) / 2.0
                self?.layer.masksToBounds = true
            })
        }
    }
    
}

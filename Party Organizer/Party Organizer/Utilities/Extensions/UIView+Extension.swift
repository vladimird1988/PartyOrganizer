//
//  UIView+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit


// MARK: - UIView extension used for easier handling UIView manipulation
extension UIView {
    
    /// Load view from nib if xib file has the same name as the UIView subclass
    static var viewFromNib: UIView? {
        return nib.instantiate(withOwner: nil, options: nil).first as? UIView
    }
    
    /// UIView identifier, i.e. class name used for getting views from the xib files (mostly used for UITableViewCells)
    static var identifier: String {
        return String(describing: self.classForCoder())
    }
    
    /// nib fetched from the xib file if file name is same as class name, i.e. identifier
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}

// MARK: - UIView extension used for easier customizing UIView appearance
extension UIView {
    
    // MARK: Properties
    
    /// Corner radius
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    /// Border width
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    
    /// Bottom border color
    @IBInspectable
    var bottomBorderColor: UIColor? {
        get {
            guard let bottomBorderColor = layer.sublayers?.first?.borderColor else {
                return nil
            }
            let color = UIColor.init(cgColor: bottomBorderColor)
            return color
        }
        set {
            let border = CALayer()
            border.backgroundColor = newValue?.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth)
            self.layer.addSublayer(border)
        }
    }
    
    
    /// Border color
    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            let color = UIColor.init(cgColor: borderColor)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    
    /// Set view to be a circle
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
    
    // MARK: Static properties
    
    /// Default tint color
    static let defaultTintColor = UIView().tintColor
    
}

//
//  UIView+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

extension UIView {
    
    //https://www.natashatherobot.com/swift-3-0-refactoring-cues/
    //https://github.com/badoo/Chatto/blob/master/ChattoAdditions/Source/Input/ReusableXibView.swift
    
    static var viewFromNib: UIView? {
        return nib.instantiate(withOwner: nil, options: nil).first as? UIView
    }
    
    static var identifier: String {
        return String(describing: self.classForCoder())
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}

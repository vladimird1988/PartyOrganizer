//
//  UITextField+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

extension UITextField {
    
    private struct AssociatedKeys {
        static var onFinishEditing = "onFinishEditing"
    }
    
    var onFinishEditing: voidMethod? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.onFinishEditing) as? voidMethod
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.onFinishEditing, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addEndEditingToolbar(title: String? = nil, onFinishEditing: voidMethod? = nil) {
        let toolbar = UIToolbar(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 40.0))
        toolbar.barStyle = .default
        toolbar.tintColor = .black
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: title, style: .plain, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finishEditing))
        ]
        inputAccessoryView = toolbar
        self.onFinishEditing = onFinishEditing
    }
    
    @objc func finishEditing() {
        endEditing(true)
        onFinishEditing?()
    }
    
    @objc func cancel() {
        endEditing(true)
    }
    
}


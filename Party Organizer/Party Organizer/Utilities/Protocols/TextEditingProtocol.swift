//
//  TextEditingProtocol.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

@objc protocol TextEditingProtocol {
    
}


@objc fileprivate protocol TextEditingPrivateProtocol {
    @objc func finishEditing()
    @objc func cancelEditing()
}

fileprivate struct AssociatedKeys {
    static var onFinishEditing = "onFinishEditing"
}

extension TextEditingPrivateProtocol {
    
    fileprivate var onFinishEditing: voidMethod? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.onFinishEditing) as? voidMethod
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.onFinishEditing, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension TextEditingProtocol {
    
    func addEndEditingToolbar(title: String? = nil, onFinishEditing: voidMethod? = nil) {
        guard let textEditingSelf = self as? TextEditingPrivateProtocol  else {
            return
        }
        let toolbar = UIToolbar(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 40.0))
        toolbar.barStyle = .default
        toolbar.tintColor = .black
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .cancel, target: textEditingSelf, action: #selector(textEditingSelf.cancelEditing)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: title, style: .plain, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: textEditingSelf, action: #selector(textEditingSelf.finishEditing)),
        ]
        (self as? UITextField)?.inputAccessoryView = toolbar
        (self as? UITextView)?.inputAccessoryView = toolbar
        textEditingSelf.onFinishEditing = onFinishEditing
    }
}

extension UIView: TextEditingPrivateProtocol {
    
    func finishEditing() {
        onFinishEditing?()
        endEditing(true)
        
    }
    
    func cancelEditing() {
        endEditing(true)
    }
}

extension UITextField: TextEditingProtocol { }
extension UITextView: TextEditingProtocol { }


//
//  TextEditingProtocol.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit


/// Protocol for managing toolbar above the keyboard for UITextField and UITextView
@objc protocol TextEditingProtocol {
    
}


/// Private helper protocol for supporting TextEditingProtocol
@objc fileprivate protocol TextEditingPrivateProtocol {
    
    /// Finish editing
    @objc func finishEditing()
    
    /// Cancel editing
    @objc func cancelEditing()
}


/// Associated keys which enables us to have properties in extension.
fileprivate struct AssociatedKeys {
    
    /// Associated key for closure / method which is called when user finishes editing the text
    static var onFinishEditing = "onFinishEditing"
}

// MARK: - TextEditingPrivateProtocol extension with a calculated property (closure for handling text editing finish event)
extension TextEditingPrivateProtocol {
    
    
    /// Calculated property (closure) for handling text editing finish event
    fileprivate var onFinishEditing: voidMethod? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.onFinishEditing) as? voidMethod
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.onFinishEditing, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


// MARK: - TextEditingProtocol extension with a method for setting toolbar above the keyboard for handling text editing events
extension TextEditingProtocol {
    
    func addEndEditingToolbar(title: String? = nil, withCancelButton: Bool = false, onFinishEditing: voidMethod? = nil) {
        guard let textEditingSelf = self as? TextEditingPrivateProtocol  else {
            return
        }
        let toolbar = UIToolbar(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 40.0))
        toolbar.barStyle = .default
        toolbar.tintColor = .black
        toolbar.items = [
            (withCancelButton ? UIBarButtonItem(barButtonSystemItem: .cancel, target: textEditingSelf, action: #selector(textEditingSelf.cancelEditing)) : UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)),
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

// MARK: - UIView conforms to TextEditingPrivateProtocol, but only in fileprivate scope
extension UIView: TextEditingPrivateProtocol {
    
    
    /// Finish editing
    fileprivate func finishEditing() {
        onFinishEditing?()
        endEditing(true)
        
    }
    
    /// Cancel editing
    fileprivate func cancelEditing() {
        endEditing(true)
    }
}


// MARK: - UITextField conforms to TextEditingProtocol
extension UITextField: TextEditingProtocol { }

// MARK: - UITextView conforms to TextEditingProtocol
extension UITextView: TextEditingProtocol { }


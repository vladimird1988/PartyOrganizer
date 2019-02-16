//
//  UITextField+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

extension UITextField: TextEditingProtocol {
    
    func finishEditing() {
        onFinishEditing?()
        endEditing(true)
    }
    
    func cancel() {
        endEditing(true)
    }
}


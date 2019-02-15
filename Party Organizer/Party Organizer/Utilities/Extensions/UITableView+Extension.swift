//
//  UITableView+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T:UIView>(type: T.Type) {
        register(type.nib, forCellReuseIdentifier: type.identifier)
    }
    
    func register<T:UIView>(type: T.Type, reuseIdentifier: String) {
        register(type.nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
}

//
//  UITableView+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

// MARK: - UITableView extension used for easier registering cells
extension UITableView {
    
    /// Register cell
    ///
    /// - Parameter type: Cell type
    func register<T:UIView>(type: T.Type) {
        register(type.nib, forCellReuseIdentifier: type.identifier)
    }
    
}

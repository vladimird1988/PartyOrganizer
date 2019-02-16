//
//  UIViewController+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    var navigationBarHeight: CGFloat {
        return (navigationController?.navigationBar.frame ?? .zero).height
    }
    
}

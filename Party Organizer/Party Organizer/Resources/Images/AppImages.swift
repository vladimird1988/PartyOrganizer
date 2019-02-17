//
//  AppImages.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/17/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

enum AppImages: String {
    case arrowIcon
    case checkMarkIcon
    case memberIcon
    case party
    case profileIcon
    case starIcon
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
    
}

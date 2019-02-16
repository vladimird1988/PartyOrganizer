//
//  UIImageView+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    // Note: Setting tint color in storyboard doesn't works (well-known XCode bug)
    @IBInspectable
    var imageTintColor: UIColor {
        get {
            return tintColor
        }
        set {
            tintColor = imageTintColor
        }
    }
    
    func setImage(url: String, placeholder: UIImage) {
        guard let url = URL(string: url) else {
            return
        }
        kf.setImage(with: url, placeholder: placeholder)
    }
    
}

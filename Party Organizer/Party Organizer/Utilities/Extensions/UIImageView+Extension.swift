//
//  UIImageView+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit
import Kingfisher


// MARK: - UIImageView extenstion with method used for set image by image url
extension UIImageView {
    
    
    /// Set image with a given url and a placeholder if image is not loaded
    ///
    /// - Parameters:
    ///   - url: Image url
    ///   - placeholder: Plceholder if image is not loaded, which is also shown while the image is still being loaded
    func setImage(url: String, placeholder: UIImage) {
        guard let url = URL(string: url) else {
            return
        }
        kf.setImage(with: url, placeholder: placeholder)
    }
    
}

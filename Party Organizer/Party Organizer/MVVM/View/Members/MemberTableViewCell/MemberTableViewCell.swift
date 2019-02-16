//
//  MemberTableViewCell.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    var isMemberSelected = false
    
    enum CellType {
        case show
        case select
    }
    
    var cellType: CellType = .show {
        didSet {
            switch cellType {
            case .show:
                selectionStyle = .default
                cellRightIcon.image = UIImage(named: "arrowIcon")
                cellRightIcon.tintColor = UIColor.lightGray.withAlphaComponent(0.5)
            case .select:
                selectionStyle = .none
                cellRightIcon.image = UIImage(named: "checkMarkIcon")
                cellRightIcon.isHidden = !isMemberSelected
                cellRightIcon.tintColor = UIView.defaultTintColor
            }
        }
    }
    
    @IBOutlet weak var cellRightIcon: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

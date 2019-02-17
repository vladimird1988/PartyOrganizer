//
//  MemberTableViewCell.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    @IBOutlet weak var imageButton: UIButton!
    
    var onOpenProfilePagePressed: voidMethod = { }
    var isMemberSelected = false
    
    var memberViewModel: MemberViewModel?
    
    enum CellType {
        case show
        case select
    }
    
    var cellType: CellType = .show {
        didSet {
            switch cellType {
            case .show:
                selectionStyle = .default
                imageButton.isHidden = true
                cellRightIcon.image = AppImages.arrowIcon.image
                cellRightIcon.tintColor = UIColor.lightGray.withAlphaComponent(0.5)
            case .select:
                selectionStyle = .none
                imageButton.isHidden = false
                cellRightIcon.image = AppImages.checkMarkIcon.image
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
    
    @IBAction func openProfilePagePressed(_ sender: Any) {
        onOpenProfilePagePressed()
    }
}

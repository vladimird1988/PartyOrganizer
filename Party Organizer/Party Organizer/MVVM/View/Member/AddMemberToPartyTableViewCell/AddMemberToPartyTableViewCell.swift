//
//  AddMemberToPartyTableViewCell.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class AddMemberToPartyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkMarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkMarkImageView.tintColor = UIView.defaultTintColor
    }

    
}

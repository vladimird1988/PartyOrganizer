

//
//  PartyTableViewCell.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class PartyTableViewCell: UITableViewCell {

    @IBOutlet weak var arrowImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        arrowImageView.tintColor = UIColor.lightGray.withAlphaComponent(0.5)    // Note: Setting tint color in storyboard doesn't works (XCode bug)
    }

}

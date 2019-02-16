

//
//  PartyTableViewCell.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class PartyTableViewCell: UITableViewCell {
    
    var partyViewModel: PartyViewModel?
    
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var partyTimeLabel: UILabel!
    @IBOutlet weak var partyDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}

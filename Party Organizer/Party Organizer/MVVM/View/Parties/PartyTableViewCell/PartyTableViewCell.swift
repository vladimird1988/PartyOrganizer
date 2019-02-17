

//
//  PartyTableViewCell.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

/// UITableViewCell which is used for showing information about the single party
class PartyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    /// Party viewModel
    var partyViewModel: PartyViewModel?
    
    // MARK: - Outlets
    
    /// UILabel which shows party name
    @IBOutlet weak var partyNameLabel: UILabel!
    
    /// UILabel which shows party start time
    @IBOutlet weak var partyTimeLabel: UILabel!
    
    /// UILabel which shows party description
    @IBOutlet weak var partyDescriptionLabel: UILabel!
    
    // MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}

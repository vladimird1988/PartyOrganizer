//
//  PartyInfoTableViewCell.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class PartyInfoTableViewCell: UITableViewCell {

    enum CellType {
        case name
        case startTime
        
        var title: String {
            switch self {
            case .name:
                return "Name"
            case .startTime:
                return "Start date and time"
            }
        }
        
        var placeholder: String {
            switch self {
            case .name:
                return "Party Name"
            case .startTime:
                return "Party date and time"
            }
        }
    }
    
    var cellType: CellType = .name {
        didSet {
            infoLabel.text = cellType.title
            infoTextField.placeholder = cellType.placeholder
        }
    }
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

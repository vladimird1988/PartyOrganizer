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
        
        var inputView: UIView? {
            switch self {
            case .name:
                return nil
            case .startTime:
                return UIDatePicker()
            }
        }
        
        var toolbarTitle: String {
            switch self {
            case .name:
                return "Party name"
            case .startTime:
                return "Party date and time"            }
        }
    }
    
    var cellType: CellType = .name {
        didSet {
            infoLabel.text = cellType.title
            infoTextField.placeholder = cellType.placeholder
            infoTextField.inputView = cellType.inputView
            infoTextField.addEndEditingToolbar(title: cellType.toolbarTitle, withCancelButton: true, onFinishEditing: {
                print("Text did end editing")
            })
        }
    }
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

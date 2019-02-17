//
//  PartyInfoTableViewCell.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit
import RxSwift

class PartyInfoTableViewCell: UITableViewCell {
    
    private var dateSelected: (Date) -> Void = { _ in }
    
    var dateSelectionObservable: Observable<Date> {
        return Observable.create({ [weak self] observer in
            self?.dateSelected = { observer.onNext($0) }
            return Disposables.create()
        })
    }
    
    enum CellType {
        case name
        case startTime
        
        var title: String {
            switch self {
            case .name:
                return AppStrings.name.localized
            case .startTime:
                return AppStrings.startDateAndTime.localized
            }
        }
        
        var placeholder: String {
            switch self {
            case .name:
                return AppStrings.partyName.localized
            case .startTime:
                return AppStrings.partyDateAndTime.localized
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
                return AppStrings.partyName.localized
            case .startTime:
                return AppStrings.partyDateAndTime.localized
            }
        }
    }
    
    var cellType: CellType = .name {
        didSet {
            infoLabel.text = cellType.title
            infoTextField.placeholder = cellType.placeholder
            infoTextField.inputView = cellType.inputView
            infoTextField.addEndEditingToolbar(title: cellType.toolbarTitle, withCancelButton: true, onFinishEditing: { [weak self] in
                if let cellType = self?.cellType {
                    switch cellType {
                    case .name:
                        break
                    case .startTime:
                        if let datePicker = self?.infoTextField.inputView as? UIDatePicker {
                            self?.infoTextField.text = datePicker.date.asString()
                            self?.dateSelected(datePicker.date)
                        }
                    }
                }
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

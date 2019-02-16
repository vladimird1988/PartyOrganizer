//
//  AddMemberToPartyTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit
import RxSwift

class AddMemberToPartyTableViewController: POTableViewController {

    let bag = DisposeBag()
    
    var memberViewModel: MemberViewModel? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = memberViewModel?.fullName
        tableView.register(type: AddMemberToPartyTableViewCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberViewModel?.allParties.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddMemberToPartyTableViewCell.identifier, for: indexPath)
        if let addMemberToPartyTableViewCell = cell as? AddMemberToPartyTableViewCell {
            addMemberToPartyTableViewCell.partyViewModel = memberViewModel?.partyViewModel(at: indexPath.row)
            addMemberToPartyTableViewCell.partyViewModel?
            .selectionObserver
            .subscribe(onNext: {
                addMemberToPartyTableViewCell.checkMarkImageView.isHidden = !$0.selected
                addMemberToPartyTableViewCell.partyNameLabel.text = $0.name
            })
            .disposed(by: bag)
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? AddMemberToPartyTableViewCell)?.partyViewModel?.isSelected.accept(true)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? AddMemberToPartyTableViewCell)?.partyViewModel?.isSelected.accept(false)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
}

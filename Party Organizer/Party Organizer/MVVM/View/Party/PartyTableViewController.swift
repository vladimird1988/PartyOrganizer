//
//  PartyTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class PartyTableViewController: POTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(type: PartyInfoTableViewCell.self)
        tableView.register(type: PartyMembersTableViewCell.self)
        tableView.register(type: PartySingleMemberTableViewCell.self)
        tableView.register(type: PartyDescriptionTableViewCell.self)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 1
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PartyInfoTableViewCell.identifier, for: indexPath)
            if let partyInfoCell = cell as? PartyInfoTableViewCell {
                switch indexPath.row {
                case 0:
                    partyInfoCell.cellType = .name
                case 1:
                    partyInfoCell.cellType = .startTime
                default:
                    break
                }
            }
            return cell
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: PartyMembersTableViewCell.identifier, for: indexPath)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: PartySingleMemberTableViewCell.identifier, for: indexPath)
                return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PartyDescriptionTableViewCell.identifier, for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50.0
        case 1:
            return 50.0
        case 2:
            return 200.0
        default:
            return 0.0
        }
    }
 

}

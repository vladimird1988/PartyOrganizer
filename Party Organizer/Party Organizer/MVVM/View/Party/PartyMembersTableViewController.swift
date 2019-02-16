//
//  PartyMembersTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class PartyMembersTableViewController: POTableViewController {

    var partyViewModel: PartyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(type: MemberTableViewCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyViewModel?.party.partyMembers.count ?? 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableViewCell.identifier, for: indexPath)
        if let memberTableViewCell = cell as? MemberTableViewCell {
            memberTableViewCell.isMemberSelected = indexPath.row % 2 == 0
            memberTableViewCell.cellType = .select
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

}

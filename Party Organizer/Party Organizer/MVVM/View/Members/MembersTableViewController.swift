//
//  MembersTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class MembersTableViewController: UITableViewController {

    let membersViewModel = MembersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(type: MemberTableViewCell.self)
        membersViewModel.getMembers()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return membersViewModel.members.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableViewCell.identifier, for: indexPath)

        return cell
    }

}

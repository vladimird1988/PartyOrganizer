//
//  AddMemberToPartyTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class AddMemberToPartyTableViewController: POTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }

}

//
//  PartiesTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class PartiesTableViewController: UITableViewController {
    
    @IBOutlet weak var backgroundTopOffset: NSLayoutConstraint!
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundView = backgroundView
        backgroundTopOffset.constant = (navigationController?.navigationBar.frame ?? .zero).height + UIApplication.shared.statusBarFrame.height
        backgroundView.layoutIfNeeded()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

}

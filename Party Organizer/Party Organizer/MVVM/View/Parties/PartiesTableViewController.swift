//
//  PartiesTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class PartiesTableViewController: POTableViewController {
    
    @IBOutlet weak var backgroundTopOffset: NSLayoutConstraint!
    @IBOutlet var backgroundView: UIView!
    
    let partiesViewModel = HomeViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(type: PartyTableViewCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfParties = partiesViewModel.parties.value.count
        if numberOfParties > 0 {
            tableView.backgroundView = nil
        } else {
            tableView.backgroundView = backgroundView
            backgroundTopOffset.constant = navigationBarHeight + statusBarHeight
            backgroundView.layoutIfNeeded()
        }
        return numberOfParties
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PartyTableViewCell.identifier, for: indexPath)
        if let partyCell = cell as? PartyTableViewCell {
            
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Deleting new item in the table
            tableView.beginUpdates()
            //yourDataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}

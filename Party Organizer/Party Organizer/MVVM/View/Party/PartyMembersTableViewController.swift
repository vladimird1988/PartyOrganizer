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

    @IBAction func savePressed(_ sender: Any) {
        partyViewModel?.save()
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProfile" {
            guard let indexPath = sender as? IndexPath else {
                return
            }
            if let dest = segue.destination as? ProfileViewController {
                dest.profileViewModel = MemberViewModel(member: AppData.shared.members.value[indexPath.row])
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyViewModel?.allMembers.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableViewCell.identifier, for: indexPath)
        if
            let memberTableViewCell = cell as? MemberTableViewCell,
            let memberViewModel = partyViewModel?.memberViewModel(at: indexPath.row) {
            memberTableViewCell.isMemberSelected = memberViewModel.isSelected.value
            memberTableViewCell.cellType = .select
            memberTableViewCell.userLabel.text = memberViewModel.fullName
            if let placeholder = UIImage(named: "profileIcon") {
                memberTableViewCell.onOpenProfilePagePressed = { [weak self] in
                    self?.performSegue(withIdentifier: "ShowProfile", sender: indexPath)
                }
                memberTableViewCell.userImage.setImage(url: memberViewModel.imageUrl, placeholder: placeholder)
            }
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let member = partyViewModel?.allMembers[indexPath.row] {
            partyViewModel?.select(member: member)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let member = partyViewModel?.allMembers[indexPath.row] {
            partyViewModel?.deselect(member: member)
        }
    }

}

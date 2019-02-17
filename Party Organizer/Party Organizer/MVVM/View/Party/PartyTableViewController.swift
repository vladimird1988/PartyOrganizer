//
//  PartyTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit
import RxSwift

class PartyTableViewController: POTableViewController {

    let bag = DisposeBag()
    var partyViewModel: PartyViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(type: PartyInfoTableViewCell.self)
        tableView.register(type: PartyMembersTableViewCell.self)
        tableView.register(type: PartySingleMemberTableViewCell.self)
        tableView.register(type: PartyDescriptionTableViewCell.self)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        if parent == nil {  // Go back
            partyViewModel?.reset()
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        partyViewModel?.save()
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            segue.identifier == "ShowProfileSegue",
            let profilePage = segue.destination as? ProfileViewController,
            let partyViewModel = partyViewModel,
            let indexPath = sender as? IndexPath {
                profilePage.profileViewModel = MemberViewModel(member: partyViewModel.party.partyMembers.value[indexPath.row - 1])
        } else if
            segue.identifier == "ShowPartyMembersSegue",
            let addMembersPage = segue.destination as? PartyMembersTableViewController {
            addMembersPage.partyViewModel = partyViewModel
        }
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
            return 1 + (partyViewModel?.viewPartyMembers.value.count ?? 0)
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
                    if let partyName = partyViewModel?.viewPartyName {
                        partyInfoCell.infoTextField.text = partyName.value
                        partyInfoCell.infoTextField.rx.text.orEmpty.bind(to: partyName).disposed(by: bag)
                    }
                case 1:
                    partyInfoCell.cellType = .startTime
                    if let partyTime = partyViewModel?.viewPartyTime {
                        partyInfoCell.infoTextField.text = partyTime.value?.asString()
                        partyInfoCell.dateSelectionObservable.bind(to: partyTime).disposed(by: bag)
                    }
                default:
                    break
                }
            }
            return cell
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: PartyMembersTableViewCell.identifier, for: indexPath)
                if let partyMembersTableViewCell = cell as? PartyMembersTableViewCell {
                    partyViewModel?.partyMembers.asObservable().subscribe(onNext: {
                        partyMembersTableViewCell.memberLabel.text = "Members (\($0.count))"
                    }).disposed(by: bag)
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: PartySingleMemberTableViewCell.identifier, for: indexPath)
                if let partySingleMemberTableViewCell = cell as? PartySingleMemberTableViewCell {
                    partySingleMemberTableViewCell.userNameLabel.text = partyViewModel?.viewPartyMembers.value[indexPath.row - 1].username
                }
                return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PartyDescriptionTableViewCell.identifier, for: indexPath)
            if let partyDescriptionTableViewCell = cell as? PartyDescriptionTableViewCell {
                if let partyDescription = partyViewModel?.viewPartyDescription {
                    partyDescriptionTableViewCell.descriptionTextView.text = partyDescription.value
                    partyDescriptionTableViewCell.descriptionTextView.rx.text.orEmpty.bind(to: partyDescription).disposed(by: bag)
                }
            }
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
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            performSegue(withIdentifier: "ShowPartyMembersSegue", sender: indexPath)
        } else if indexPath.section == 1 && indexPath.row > 0 {
            performSegue(withIdentifier: "ShowProfileSegue", sender: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1 && indexPath.row > 0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            partyViewModel?.deleteMember(at: indexPath.row - 1)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}

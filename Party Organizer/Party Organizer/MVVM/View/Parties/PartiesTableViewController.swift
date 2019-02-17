//
//  PartiesTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit
import RxSwift

class PartiesTableViewController: POTableViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var backgroundTopOffset: NSLayoutConstraint!
    @IBOutlet var backgroundView: UIView!
    
    let partiesViewModel = HomeViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(type: PartyTableViewCell.self)
        partiesViewModel.partiesObserver.subscribe(onNext: { [weak self] in
            switch $0 {
            case .addNewParty:
                self?.tableView.beginUpdates()
                self?.tableView.insertRows(at: [IndexPath(row: AppData.shared.parties.value.count - 1, section: 0)], with: .automatic)
                self?.tableView.endUpdates()
            case .deleteParty(let position):
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: [IndexPath(row: position, section: 0)], with: .automatic)
                self?.tableView.endUpdates()
            default:
                break
            }
        }).disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = AppStrings.parties.localized
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: AppStrings.add.localized, style: .plain, target: self, action: #selector(addNewParty))
    }
    
    @objc func addNewParty() {
        performSegue(withIdentifier: "AddNewPartySegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNewPartySegue" {
            if let partyPage = segue.destination as? PartyTableViewController {
                partyPage.partyViewModel = PartyViewModel.newPartyViewModel
            }
        } else if segue.identifier == "ShowPartySegue" {
            if
                let partyViewModel = sender as? PartyViewModel,
                let partyPage = segue.destination as? PartyTableViewController {
                partyPage.partyViewModel = partyViewModel
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfParties = AppData.shared.parties.value.count
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
            let partyViewModel = partiesViewModel.partyViewModel(at: indexPath.row)
            partyCell.partyViewModel = partyViewModel
            partyViewModel.partyName.bind(to: partyCell.partyNameLabel.rx.text).disposed(by: bag)
            partyViewModel.partyDescription.subscribe(onNext: {
                partyCell.partyDescriptionLabel.text = $0
                tableView.beginUpdates()
                tableView.endUpdates()
            }).disposed(by: bag)
            partyViewModel.partyTime.subscribe(onNext: {
                partyCell.partyTimeLabel.text = $0?.asString()
            }).disposed(by: bag)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let partyViewModel = (tableView.cellForRow(at: indexPath) as? PartyTableViewCell)?.partyViewModel
        performSegue(withIdentifier: "ShowPartySegue", sender: partyViewModel)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            partiesViewModel.deleteParty(at: indexPath.row)
        }
    }
    
}

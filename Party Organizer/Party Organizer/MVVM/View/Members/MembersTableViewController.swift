//
//  MembersTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit
import RxSwift

class MembersTableViewController: POTableViewController, SegueHandlerType {

    enum SegueIdentifier: String {
        case ShowProfile
    }
    
    let membersViewModel = HomeViewModel.shared
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(type: MemberTableViewCell.self)
        
        AppData.shared.members.asObservable()
        .subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: bag)
        
        membersViewModel.getMembers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = AppStrings.members.localized
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.shared.members.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableViewCell.identifier, for: indexPath)
        if let memberCell = cell as? MemberTableViewCell {
            memberCell.cellType = .show
            memberCell.userLabel.text = AppData.shared.members.value[indexPath.row].username
            if let placeholder = AppImages.profileIcon.image {
                memberCell.userImage.setImage(url: AppData.shared.members.value[indexPath.row].photo, placeholder: placeholder)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegueWithIdentifier(segueIdentifier: .ShowProfile, sender: indexPath as AnyObject)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.ShowProfile.rawValue {
            guard let indexPath = sender as? IndexPath else {
                return
            }
            if let profilePage = segue.destination as? ProfileViewController {
                profilePage.profileViewModel = MemberViewModel(member: AppData.shared.members.value[indexPath.row])
            }
        }
    }
}

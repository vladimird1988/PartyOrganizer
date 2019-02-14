//
//  MembersViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController {

    let membersViewModel = MembersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        membersViewModel.getMembers()
    }

}

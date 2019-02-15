//
//  ProfileViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileViewModel: MemberViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func callPressed(_ sender: Any) {
        profileViewModel?.makeACall()
    }
    
}

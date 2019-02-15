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
    
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if
            let profileImageUrl = profileViewModel?.imageUrl,
            let placeholder = UIImage(named: "profileIcon") {
            profileImageView.setImage(url: profileImageUrl, placeholder: placeholder)
        }
        
    }
    
    @IBAction func callPressed(_ sender: Any) {
        profileViewModel?.makeACall()
    }
    
}

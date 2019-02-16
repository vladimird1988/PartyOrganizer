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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "Full name: \(profileViewModel?.fullName ?? "-")"
        genderLabel.text = "Gender: \(profileViewModel?.gender ?? "-")"
        emailLabel.text = "email: \(profileViewModel?.email ?? "-")"
        aboutLabel.text = profileViewModel?.about ?? "-"
        if
            let profileImageUrl = profileViewModel?.imageUrl,
            let placeholder = UIImage(named: "profileIcon") {
            profileImageView.setImage(url: profileImageUrl, placeholder: placeholder)
        }
        
    }
    
    @IBAction func callPressed(_ sender: Any) {
        profileViewModel?.makeACall()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMemberToPartySegue" {
            if let page = segue.destination as? AddMemberToPartyTableViewController {
                page.memberViewModel = profileViewModel
            }
        }
    }
    
}

//
//  MemberViewModel.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class MemberViewModel: NSObject {

    let member: Member
    
    init(member: Member) {
        self.member = member
    }
    
    func makeACall() {
        let phoneNumber = member.cell
        let phoneNumberRegex = "^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\\s\\./0-9]*$"
        let cleanPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        guard
            NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex).evaluate(with: phoneNumber),
            let url = URL(string: "tel://\(cleanPhoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
                    return
            }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}

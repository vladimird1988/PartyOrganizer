//
//  MembersViewModel.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import RxCocoa

class MembersViewModel: NSObject {

    let members = BehaviorRelay<[Member]>(value: [])
    
    override init() {
        super.init()

        members.accept(Member.allMembers)
    }
    
    func getMembers() {
        BackendManager.sharedInstance.getMembers()
        .done { [weak self] in
            print("Members: \($0)")
            if let membersDataArray = $0["profiles"] as? [[String: Any]] {
                let members = membersDataArray.map { Member(data: $0) }
                members.forEach { $0.save() }
                self?.members.accept(members)
                print("Members parsed")
            }
        }
        .cauterize()
    }
    
}

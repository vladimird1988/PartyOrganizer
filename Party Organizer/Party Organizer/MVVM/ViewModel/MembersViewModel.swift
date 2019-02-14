//
//  MembersViewModel.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import RxCocoa
import SwiftyJSON

class MembersViewModel: NSObject {

    let members = BehaviorRelay<[Member]>(value: [])
    
    func getMembers() {
        BackendManager.sharedInstance.getMembers()
        .done {
            print("Members: \($0)")
            if let membersDataArray = $0["profiles"] as? [[String: Any]] {
                let members = membersDataArray.map {
                    Member(data: $0)
                }
                print("Members parsed")
            }
        }
        .cauterize()
    }
    
}

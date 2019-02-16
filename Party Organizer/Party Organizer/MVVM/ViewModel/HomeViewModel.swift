//
//  HomeViewModel.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import RxCocoa

class HomeViewModel: NSObject {

    static let shared = HomeViewModel()
    
    let appData = AppData()
    
    func getMembers() {
        BackendManager.sharedInstance.getMembers()
            .done { [weak self] in
                print("Members: \($0)")
                if let membersDataArray = $0["profiles"] as? [[String: Any]] {
                    let members = membersDataArray.map { Member(data: $0) }
                    members.forEach { $0.save() }
                    self?.appData.members.accept(members)
                    print("Members parsed")
                }
            }
            .cauterize()
    }
    
}

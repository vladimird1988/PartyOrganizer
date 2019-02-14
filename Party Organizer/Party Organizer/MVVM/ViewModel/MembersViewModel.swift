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
    
    func getMembers() {
        
    }
    
}

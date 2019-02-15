//
//  PartiesViewModel.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import RxCocoa

class PartiesViewModel: NSObject {

    let parties = BehaviorRelay<[Party]>(value: [])
    
    override init() {
        super.init()
        parties.accept(Party.allParties)
    }
    
}

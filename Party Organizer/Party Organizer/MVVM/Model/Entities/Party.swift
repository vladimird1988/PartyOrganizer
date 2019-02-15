//
//  Party.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class Party: NSObject {

    let name: String
    let startDate: Date
    let partyDescription: String
    
    
    
    init(name: String, startDate: Date, partyDescription: String) {
        self.name = name
        self.startDate = startDate
        self.partyDescription = partyDescription
    }
    
}

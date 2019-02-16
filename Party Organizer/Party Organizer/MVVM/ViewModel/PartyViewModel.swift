//
//  PartyViewModel.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

class PartyViewModel: NSObject {

    let party: Party
    
    init(party: Party) {
        self.party = party
    }
    
    static var newPartyViewModel: PartyViewModel {
        return PartyViewModel(party: Party.newParty)
    }
    
}

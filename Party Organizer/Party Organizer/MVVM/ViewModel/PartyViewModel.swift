//
//  PartyViewModel.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PartyViewModel: NSObject {

    var party: Party {
        didSet {
            partyName.accept(party.partyName)
        }
    }
    
    let partyName = BehaviorRelay<String>(value: "")
    let partyTime = BehaviorRelay<Date?>(value: nil)
    
    init(party: Party) {
        self.party = party
    }
    
    static var newPartyViewModel: PartyViewModel {
        return PartyViewModel(party: Party.newParty)
    }
    
    func save() {
        party.partyName = partyName.value
        party.startTime = partyTime.value
        party.save()
    }
    
}

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
            partyDescription.accept(party.partyDescription)
            partyTime.accept(party.startTime)
        }
    }
    
    let partyId: Int64
    let partyName = BehaviorRelay<String>(value: "")
    let partyDescription = BehaviorRelay<String>(value: "")
    let partyTime = BehaviorRelay<Date?>(value: nil)
    
    init(party: Party) {
        self.party = party
        self.partyId = party.partyId
    }
    
    static var newPartyViewModel: PartyViewModel {
        return PartyViewModel(party: Party.newParty)
    }
    
    func save() {
        party.partyId = partyId
        party.partyDescription = partyDescription.value
        party.partyName = partyName.value
        party.startTime = partyTime.value
        party.save()
    }
    
}

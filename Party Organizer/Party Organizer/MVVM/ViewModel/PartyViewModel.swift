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

    var homeViewModel: HomeViewModel?
    
    var party: Party
    
    let isSelected = BehaviorRelay<Bool>(value: false)
    
    let partyId: Int64
    let viewPartyName = BehaviorRelay<String>(value: "")
    let viewPartyDescription = BehaviorRelay<String>(value: "")
    let viewPartyTime = BehaviorRelay<Date?>(value: nil)
    
    var partyName: BehaviorRelay<String> { return party.partyName }
    var partyTime: BehaviorRelay<Date?> { return party.startTime }
    var partyDescription: BehaviorRelay<String> { return party.partyDescription }
    
    init(party: Party) {
        self.party = party
        self.partyId = party.partyId
        super.init()
        update()
    }
    
    func reset() {
        update()
    }
    
    func update() {
        viewPartyName.accept(party.partyName.value)
        viewPartyDescription.accept(party.partyDescription.value)
        viewPartyTime.accept(party.startTime.value)
    }
    
    static var newPartyViewModel: PartyViewModel {
        return PartyViewModel(party: Party.newParty)
    }
    
    func save() {
        party.partyId = partyId
        party.partyDescription.accept(viewPartyDescription.value)
        party.partyName.accept(viewPartyName.value)
        party.startTime.accept(viewPartyTime.value)
        AppData.shared.add(party: party)
    }
    
    var selectionObserver: Observable<(selected: Bool, name: String)> {
        let observable = Observable.combineLatest(isSelected.asObservable(), partyName.asObservable(), resultSelector: { (selected: $0, name: $1) })
        return observable.do(onNext: { [weak self] in
            guard let party = self?.party else { return }
            if $0.selected {
                self?.homeViewModel?.select(party: party)
            } else {
                self?.homeViewModel?.deselect(party: party)
            }
        })
    }
    
}

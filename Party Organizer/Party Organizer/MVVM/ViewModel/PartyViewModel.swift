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

    var memberViewModel: MemberViewModel?
    
    var party: Party
    
    let isSelected = BehaviorRelay<Bool>(value: false)
    
    let partyId: Int64
    let viewPartyMembers = BehaviorRelay<[Member]>(value: [])
    let viewPartyName = BehaviorRelay<String>(value: "")
    let viewPartyDescription = BehaviorRelay<String>(value: "")
    let viewPartyTime = BehaviorRelay<Date?>(value: nil)
    
    var partyMembers: BehaviorRelay<[Member]> { return party.partyMembers }
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
        viewPartyMembers.accept(party.partyMembers.value)
    }
    
    static var newPartyViewModel: PartyViewModel {
        return PartyViewModel(party: Party.newParty)
    }
    
    func save() {
        party.partyId = partyId
        party.partyDescription.accept(viewPartyDescription.value)
        party.partyName.accept(viewPartyName.value)
        party.startTime.accept(viewPartyTime.value)
        party.partyMembers.accept(viewPartyMembers.value)
        party.partyMembers.value.forEach {
            if $0.parties.contains(party) {
                $0.parties.append(party)
            }
        }
        party.save()
        AppData.shared.add(party: party)
    }
    
    func deleteMember(at position: Int) {
        viewPartyMembers.accept(viewPartyMembers.value.filter { $0.id != viewPartyMembers.value[position].id })
    }
    
    var selectionObserver: Observable<(selected: Bool, name: String)> {
        let observable = Observable.combineLatest(isSelected.asObservable(), partyName.asObservable(), resultSelector: { (selected: $0, name: $1) })
        return observable.do(onNext: { [weak self] in
            guard let party = self?.party else { return }
            if $0.selected {
                self?.memberViewModel?.select(party: party)
            } else {
                self?.memberViewModel?.deselect(party: party)
            }
        })
    }
    
    func select(member: Member) {
        viewPartyMembers.accept(Array(Set(viewPartyMembers.value + [member])))
    }
    
    func deselect(member: Member) {
        viewPartyMembers.accept(Array(Set(viewPartyMembers.value.filter { $0.id != member.id })))
    }
    
    var allMembers: [Member] {
        return AppData.shared.members.value
    }
    
    func memberViewModel(at position: Int) -> MemberViewModel {
        let member = allMembers[position]
        let memberViewModel = MemberViewModel(member: member)
        memberViewModel.isSelected.accept(member.parties.contains(party))
        return memberViewModel
    }
    
}

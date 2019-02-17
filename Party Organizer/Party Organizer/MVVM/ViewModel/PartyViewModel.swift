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
import PromiseKit

class PartyViewModel: NSObject {
    
    enum Key: String {
        case partyId
    }
    
    var memberViewModel: MemberViewModel?
    
    var party: Party
    
    let isSelected = BehaviorRelay<Bool>(value: false)
    
    let partyEvent = BehaviorRelay<Void>(value: { }())
    
    let partyId: Int64
    let viewPartyMembers = BehaviorRelay<[Member]>(value: [])
    let viewPartyName = BehaviorRelay<String>(value: "")
    let viewPartyDescription = BehaviorRelay<String>(value: "")
    let viewPartyTime = BehaviorRelay<Date?>(value: nil)
    
    var partyMembers: BehaviorRelay<[Member]> { return party.partyMembers }
    var partyName: BehaviorRelay<String> { return party.partyName }
    var partyTime: BehaviorRelay<Date?> { return party.startTime }
    var partyDescription: BehaviorRelay<String> { return party.partyDescription }
    
    var membersObservable: Observable<Int> {
        return Observable.combineLatest(partyEvent.asObservable(), viewPartyMembers.asObservable(), resultSelector: { $1.count })
    }
    
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
    
    func save() -> Promise<Void> {
        return Promise { handler in
            guard !viewPartyName.value.isEmpty else {
                handler.reject(PartyOrganizerError.custom(AppStrings.partyNameIsEmpty.localized))
                return
            }
            guard viewPartyName.value.count > 5 else {
                handler.reject(PartyOrganizerError.custom(AppStrings.partyNameIsTooShort.localized))
                return
            }
            guard viewPartyTime.value != nil else {
                handler.reject(PartyOrganizerError.custom(AppStrings.partyStartTimeIsNotSet.localized))
                return
            }
            guard !viewPartyDescription.value.isEmpty else {
                handler.reject(PartyOrganizerError.custom(AppStrings.partyDescriptionIsEmpty.localized))
                return
            }
            guard viewPartyDescription.value.count > 20 else {
                handler.reject(PartyOrganizerError.custom(AppStrings.partyDescriptionIsTooShort.localized))
                return
            }
            party.partyId = partyId
            party.partyDescription.accept(viewPartyDescription.value)
            party.partyName.accept(viewPartyName.value)
            party.startTime.accept(viewPartyTime.value)
            party.partyMembers.value.forEach {
                $0.parties.removeAll(where: { $0.partyId == partyId })
                $0.save()
            }
            party.partyMembers.accept(viewPartyMembers.value)
            party.partyMembers.value.forEach {
                if !$0.parties.contains(party) {
                    $0.parties.append(party)
                    $0.save()
                }
            }
            party.save()
            AppData.shared.add(party: party)
            partyEvent.accept({ }())
            handler.fulfill_()
        }
    }
    
    func deleteMember(at position: Int) {
        let deletedMember = viewPartyMembers.value[position]
        viewPartyMembers.accept(viewPartyMembers.value.filter { $0.id != deletedMember.id })
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
        memberViewModel.partyViewModel = self
        memberViewModel.isSelected.accept(member.parties.contains(party))
        return memberViewModel
    }
    
}

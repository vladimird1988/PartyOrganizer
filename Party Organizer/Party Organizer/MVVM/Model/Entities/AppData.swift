//
//  AppData.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AppData: NSObject {

    enum DataEvent {
        case noEvents
        case addNewParty
        case deleteParty(Party)
    }
    
    private var onAddParty: voidMethod = { }
    
    lazy var dataEventObserver: Observable<DataEvent> = {
        return Observable<DataEvent>.create { [weak self] observer in
            self?.onAddParty = {
                observer.onNext(.addNewParty)
            }
            return Disposables.create()
        }
    }()
    
    static let shared = AppData()
    
    let parties = BehaviorRelay<[Party]>(value: [])
    let members = BehaviorRelay<[Member]>(value: [])
    
    override init() {
        
        super.init()
        members.accept({
            let allDBMembers = DBMember.all() as? [DBMember] ?? []
            return allDBMembers.map { Member(dbMember: $0) }
            }())
        parties.accept({
            let allDBParties = DBParty.all() as? [DBParty] ?? []
            return allDBParties.map { dbParty in
                let party = Party(dbParty: dbParty)
                let partyMembers: [DBMember] = (dbParty.members?.allObjects as? [DBMember] ?? [])
                partyMembers.forEach { partyDBMember in
                    let member = members.value.first(where: { member in
                        return member.id == partyDBMember.id
                    }) ?? Member(dbMember: partyDBMember)
                    party.partyMembers.append(member)
                    member.parties.append(party)
                }
                return party
            }
            }())
    }
    
    func add(party: Party) {
        if !parties.value.contains(party) {
            parties.accept(AppData.shared.parties.value + [party])
            onAddParty()
        }
        
    }
    
    func delete(party: Party) {
        
    }
    
}

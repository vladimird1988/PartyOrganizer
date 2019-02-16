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
import AERecord

class AppData: NSObject {

    enum DataEvent {
        case noEvents
        case addNewParty
        case deleteParty(Int)
    }
    
    private var onAddParty: voidMethod = { }
    private var onDeleteParty: (Int) -> Void = { _ in }
    
    lazy var dataEventObserver: Observable<DataEvent> = {
        return Observable<DataEvent>.create { [weak self] observer in
            self?.onAddParty = {
                observer.onNext(.addNewParty)
            }
            self?.onDeleteParty = {
                observer.onNext(.deleteParty($0))
            }
            return Disposables.create()
        }
    }()
    
    static let shared = AppData()
    
    private var allDBParties: [DBParty] {
        return (DBParty.all() as? [DBParty] ?? [])
    }
    private var allDBMembers: [DBMember] {
        return DBMember.all() as? [DBMember] ?? []
    }
    
    let parties = BehaviorRelay<[Party]>(value: [])
    let members = BehaviorRelay<[Member]>(value: [])
    
    override init() {
        
        super.init()
        members.accept({
            return allDBMembers.map { Member(dbMember: $0) }
        }())
        parties.accept({
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
            parties.accept(parties.value + [party])
            onAddParty()
        }
        save()
    }
    
    func deleteParty(at position: Int) {
        if parties.value.count > position {
            let party = parties.value[position]
            parties.accept(parties.value.filter { $0.partyId != party.partyId })
            onDeleteParty(position)
        }
        save()
    }
    
    func save() {
        allDBParties.forEach {
            $0.delete()
        }
        parties.value.forEach {
            $0.save()
        }
    }
    
}

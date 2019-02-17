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

/// Entity used for handling global app data
class AppData: NSObject {

    // MARK: - Internal types
    
    /// Enum for handling changes in parties data
    ///
    /// - noEvents: Nothing happened
    /// - addNewParty: New party created
    /// - deleteParty: A party deleted
    enum DataEvent {
        case noEvents
        case addNewParty
        case deleteParty(Int)
    }
    
    // MARK: - Static properties
    
    /// Shared instance
    static let shared = AppData()
    
    // MARK: - Instance properties
    
    /// Handler for creation of new party
    private var onAddParty: voidMethod = { }
    
    /// Handler for deletion of a single party
    private var onDeleteParty: intMethod = { _ in }
    
    let parties = BehaviorRelay<[Party]>(value: [])
    let members = BehaviorRelay<[Member]>(value: [])
    
    /// Observer for changes in parties data (creation and deletion)
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
    
    // MARK: - Calculated properties
    
    
    /// Parties fetched from the CoreData
    private var allDBParties: [DBParty] {
        return (DBParty.all() as? [DBParty] ?? [])
    }
    
    /// Members fetched from the CoreData
    private var allDBMembers: [DBMember] {
        return DBMember.all() as? [DBMember] ?? []
    }
    
    // MARK: - Constructor
    
    /// Constructor
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
                    party.partyMembers.accept(party.partyMembers.value + [member])
                    member.parties.append(party)
                }
                return party
            }
        }())
    }
    
    // MARK: - Methods
    
    
    /// Add new party
    ///
    /// - Parameter party: Party instance
    func add(party: Party) {
        if !parties.value.contains(party) {
            parties.accept(parties.value + [party])
            onAddParty()
        }
    }
    
    
    /// Delete a party
    ///
    /// - Parameter position: Position of a party in parties array which should be deleted
    func deleteParty(at position: Int) {
        if parties.value.count > position {
            let party = parties.value[position]
            parties.accept(parties.value.filter { $0.partyId != party.partyId })
            onDeleteParty(position)
        }
    }
    
}

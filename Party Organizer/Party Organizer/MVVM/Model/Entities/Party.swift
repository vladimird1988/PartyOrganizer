//
//  Party.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import RxCocoa

class Party: NSObject {

    enum Key: String {
        case partyId
        case partyName
        case startDate
        case partyDescription
    }
    
    var partyId: Int64
    let partyName = BehaviorRelay<String>(value: "")
    let startTime = BehaviorRelay<Date?>(value: nil)
    let partyDescription = BehaviorRelay<String>(value: "")
    var partyMembers = BehaviorRelay<[Member]>(value: [])
    
    static var newParty: Party {
        return Party(partyName: "", partyDescription: "")
    }
    
    init( partyName: String, startTime: Date? = nil, partyDescription: String) {
        let generatedPartyId: Int = {
            let lastId = UserDefaults.standard.integer(forKey: Key.partyId.rawValue)
            let generatedId = lastId + 1
            UserDefaults.standard.set(generatedId, forKey: Key.partyId.rawValue)
            return generatedId
        }()
        self.partyId = Int64(generatedPartyId)
        self.partyName.accept(partyName)
        self.startTime.accept(startTime)
        self.partyDescription.accept(partyDescription)
    }

    
    @discardableResult func save() -> DBParty {
        let dbParty = DBParty.first(with: [Key.partyId.rawValue: partyId]) ?? DBParty.create()
        dbParty.partyId = partyId
        dbParty.partyName = partyName.value
        dbParty.startTime = startTime.value
        dbParty.partyDescription = partyDescription.value
        CoreDataManager.shared.saveContext()
        return dbParty
    }
    
    init(dbParty: DBParty) {
        partyId = dbParty.partyId
        partyName.accept(dbParty.partyName ?? "")
        startTime.accept(dbParty.startTime)
        partyDescription.accept(dbParty.partyDescription ?? "")
    }
    
}

//
//  Party.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation

class Party: NSObject {

    enum Key: String {
        case partyId
        case partyName
        case startDate
        case partyDescription
    }
    
    var partyId: Int64
    var partyName: String
    var startTime: Date?
    var partyDescription: String
    var partyMembers = [Member]()
    
    static var newParty: Party {
        return Party(partyId: 0, partyName: "", partyDescription: "")
    }
    
    init(partyId: Int? = nil, partyName: String, startTime: Date? = nil, partyDescription: String) {
        let generatedPartyId: Int = partyId ?? {
            let lastId = UserDefaults.standard.integer(forKey: Key.partyId.rawValue)
            let generatedId = lastId + 1
            UserDefaults.standard.set(generatedId, forKey: Key.partyId.rawValue)
            return generatedId
        }()
        self.partyId = Int64(generatedPartyId)
        self.partyName = partyName
        self.startTime = startTime
        self.partyDescription = partyDescription
    }

    
    func save() {
        let dbParty = DBParty.first(with: [Key.partyId.rawValue: partyId]) ?? DBParty.create()
        dbParty.partyId = partyId
        dbParty.partyName = partyName
        dbParty.startTime = startTime
        dbParty.partyDescription = partyDescription
        CoreDataManager.shared.saveContext()
    }
    
    init(dbParty: DBParty) {
        partyId = dbParty.partyId
        partyName = dbParty.partyName ?? ""
        startTime = dbParty.startTime
        partyDescription = dbParty.partyDescription ?? ""
    }
    
}

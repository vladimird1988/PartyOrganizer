//
//  Party.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import RxCocoa


/// Party entity
class Party: NSObject {

    // MARK: - Internal types
    
    /// Properties keys used for the CoreData querying
    ///
    /// - partyId: Party id
    /// - partyName: Party name
    /// - startDate: Party start time
    /// - partyDescription: Party description
    enum Key: String {
        case partyId
        case partyName
        case startDate
        case partyDescription
    }
    
    // MARK: - Static properties
    
    /// Static calculated property which returns new Party instance
    static var newParty: Party {
        return Party(partyName: "", partyDescription: "")
    }
    
    // MARK: - Instance properties
    
    /// Party id
    var partyId: Int64
    
    /// Party name
    let partyName = BehaviorRelay<String>(value: "")
    
    /// Party start time
    let startTime = BehaviorRelay<Date?>(value: nil)
    
    /// Party description
    let partyDescription = BehaviorRelay<String>(value: "")
    
    /// Party members
    var partyMembers = BehaviorRelay<[Member]>(value: [])
    
    // MARK: - Contructors
    
    /// Constructor which initializes new instance using DBParty elemenet fetched from the CoreData
    ///
    /// - Parameter dbParty: DBParty instance fetched from the CoreData
    init(dbParty: DBParty) {
        partyId = dbParty.partyId
        partyName.accept(dbParty.partyName ?? "")
        startTime.accept(dbParty.startTime)
        partyDescription.accept(dbParty.partyDescription ?? "")
    }
    
    
    /// Constructor which generates new Party instance using several different params
    ///
    /// - Parameters:
    ///   - partyName: Party name
    ///   - startTime: Party start time
    ///   - partyDescription: Party description
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

    
    /// Save Party entity in CoreData
    ///
    /// - Returns: DBParty instance, i.e. object saved in CoreData
    @discardableResult func save() -> DBParty {
        let dbParty = DBParty.first(with: [Key.partyId.rawValue: partyId]) ?? DBParty.create()
        dbParty.partyId = partyId
        dbParty.partyName = partyName.value
        dbParty.startTime = startTime.value
        dbParty.partyDescription = partyDescription.value
        CoreDataManager.shared.saveContext()
        return dbParty
    }
    
}

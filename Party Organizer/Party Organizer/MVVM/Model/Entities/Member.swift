//
//  Member.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import AERecord
import SwiftyJSON


/// Member entity
final class Member: NSObject {

    // MARK: - Internal types
    
    private enum Key: String {
        case id
        case username
        case cell
        case email
        case gender
        case photo
        case aboutMe
    }
    
    // MARK: - Instance properties
    
    var id: Int64
    var username: String = ""
    var cell: String = ""
    var photo: String = ""
    var email: String = ""
    var gender: String = ""
    var aboutMe: String = ""
    
    var parties = [Party]() {
        didSet {
            parties.forEach {
                if !$0.partyMembers.value.contains(self) {
                    $0.partyMembers.accept($0.partyMembers.value + [self])
                }
            }
        }
    }
    
    // MARK: - Constructor
    
    /// Constructor
    ///
    /// - Parameter dbMember: Member from the CoreData
    init(dbMember: DBMember) {
        id = dbMember.id
        aboutMe = dbMember.aboutMe ?? ""
        cell = dbMember.cell ?? ""
        email = dbMember.email ?? ""
        gender = dbMember.gender ?? ""
        photo = dbMember.photo ?? ""
        username = dbMember.username ?? ""
    }
    
    static func createOrUpdate(data: [String: Any]) -> Member {
        let json = JSON(data)
        let id = json[Key.id.rawValue].int64Value
        if let member = AppData.shared.members.value.first(where: { $0.id == id }) {
            member.update(data: data)
            return member
        } else {
            return Member(data: data)
        }
    }
    
    private func update(data: [String: Any]) {
        let json = JSON(data)
        id = json[Key.id.rawValue].int64Value
        aboutMe = json[Key.aboutMe.rawValue].stringValue
        cell = json[Key.cell.rawValue].stringValue
        email = json[Key.email.rawValue].stringValue
        gender = json[Key.gender.rawValue].stringValue
        username = json[Key.username.rawValue].stringValue
        photo = json[Key.photo.rawValue].stringValue
    }
    
    init(data: [String: Any]) {
        let json = JSON(data)
        id = json[Key.id.rawValue].int64Value
        super.init()
        update(data: data)
    }
    
    @discardableResult func save() -> DBMember {
        let dbMember = DBMember.first(with: [Key.id.rawValue: id]) ?? DBMember.create()
        dbMember.id = id
        dbMember.aboutMe = aboutMe
        dbMember.cell = cell
        dbMember.email = email
        dbMember.gender = gender
        dbMember.photo = photo
        dbMember.username = username
        dbMember.parties?.forEach {
            if let dbParty = $0 as? DBParty {
                dbMember.removeFromParties(dbParty)
            }
        }
        parties.forEach {
            dbMember.addToParties($0.save())
        }
        CoreDataManager.shared.saveContext()
        return dbMember
    }
    
}


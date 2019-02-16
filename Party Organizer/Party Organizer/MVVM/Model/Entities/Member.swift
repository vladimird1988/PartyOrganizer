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

final class Member: NSObject {

    private enum Key: String {
        case id
        case username
        case cell
        case email
        case gender
        case photo
        case aboutMe
    }
    
    var id: Int64
    var username: String
    var cell: String
    var photo: String
    var email: String
    var gender: String
    var aboutMe: String
    
    var parties = [Party]()
    
    init(dbMember: DBMember) {
        id = dbMember.id
        aboutMe = dbMember.aboutMe ?? ""
        cell = dbMember.cell ?? ""
        email = dbMember.email ?? ""
        gender = dbMember.gender ?? ""
        photo = dbMember.photo ?? ""
        username = dbMember.username ?? ""
        parties = (dbMember.parties?.allObjects as? [DBParty] ?? []).map { Party(dbParty: $0) }
    }
    
    init(data: [String: Any]) {
        let json = JSON(data)
        id = json[Key.id.rawValue].int64Value
        aboutMe = json[Key.aboutMe.rawValue].stringValue
        cell = json[Key.cell.rawValue].stringValue
        email = json[Key.email.rawValue].stringValue
        gender = json[Key.gender.rawValue].stringValue
        username = json[Key.username.rawValue].stringValue
        photo = json[Key.photo.rawValue].stringValue
    }
    
    func save() {
        let dbMember = DBMember.first(with: [Key.id.rawValue: id]) ?? DBMember.create()
        dbMember.id = id
        dbMember.aboutMe = aboutMe
        dbMember.cell = cell
        dbMember.email = email
        dbMember.gender = gender
        dbMember.photo = photo
        dbMember.username = username
        CoreDataManager.shared.saveContext()
    }
    
}


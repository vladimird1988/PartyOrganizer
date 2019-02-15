//
//  Member.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import AERecord

final class Member: NSObject, Codable {

    private enum Key: String {
        case memberId
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
    
    func save() {
        let dbMember = DBMember.first(with: [Key.memberId.rawValue: id]) ?? DBMember.create()
        dbMember.memberId = id
        dbMember.aboutMe = aboutMe
        dbMember.cell = cell
        dbMember.email = email
        dbMember.gender = gender
        dbMember.photo = photo
        dbMember.username = username
        CoreDataManager.shared.saveContext()
    }
    
    init(dbMember: DBMember) {
        id = dbMember.memberId
        aboutMe = dbMember.aboutMe ?? ""
        cell = dbMember.cell ?? ""
        email = dbMember.email ?? ""
        gender = dbMember.gender ?? ""
        photo = dbMember.photo ?? ""
        username = dbMember.username ?? ""
    }
    
    static var allMembers: [Member] {
        let allDBMembers = DBMember.all() as? [DBMember] ?? []
        return allDBMembers.map { Member(dbMember: $0) }
    }
    
}


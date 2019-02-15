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
        case id
        case username
        case cell
        case email
        case gender
        case photo
        case aboutMe
    }
    
    var id: Int
    var username: String
    var cell: String
    var photo: String
    var email: String
    var gender: String
    var aboutMe: String
    
}


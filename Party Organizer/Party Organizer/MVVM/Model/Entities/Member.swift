//
//  Member.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Member: NSObject {

    private enum Key: String {
        case id
        case username
        case cell
        case email
        case gender
        case photo
        case aboutMe
    }
    
    let id: Int64
    let username: String
    let cell: String
    let photo: String
    let email: String
    let gender: String
    let aboutMe: String
    
    init(data: [String: Any]) {
        let json = JSON(data)
        id = json[Key.id.rawValue].int64Value
        username = json[Key.username.rawValue].stringValue
        cell = json[Key.cell.rawValue].stringValue
        photo = json[Key.photo.rawValue].stringValue
        aboutMe = json[Key.aboutMe.rawValue].stringValue
        email = json[Key.email.rawValue].stringValue
        gender = json[Key.gender.rawValue].stringValue
    }
    
}

//
//  Server.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation

struct Server {
    
    static var baseUrl: String {
         return Bundle.main.object(forInfoDictionaryKey: "ServerBaseUrl") as? String ?? ""
    }
    
    static let members = "profiles.json"
    
    
}

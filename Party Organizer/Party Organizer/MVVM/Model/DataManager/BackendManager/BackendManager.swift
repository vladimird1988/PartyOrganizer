//
//  BackendManager.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import PromiseKit

/// Backend manager used for fetching data from the server
class BackendManager: NSObject {

    
    /// Shared instance
    static let sharedInstance = BackendManager()
    
    
    /// Method for fetching members
    ///
    /// - Returns: Promise which returns json fetched from the server
    func getMembers() -> Promise<[String: Any]> {
        return Promise { handler in
            guard let url = URL(string: Server.baseUrl)?.appendingPathComponent(Server.members) else {
                handler.reject(PartyOrganizerError.invalidUrl)
                return
            }
            NetworkManager.shared.performGetRequest(url: url)
            .done {
                if let response = $0 as? [String: Any] {
                    handler.fulfill(response)
                } else {
                    handler.reject(PartyOrganizerError.invalidResponse)
                }
            }
            .catch { handler.reject($0) }
        }
    }
    
}

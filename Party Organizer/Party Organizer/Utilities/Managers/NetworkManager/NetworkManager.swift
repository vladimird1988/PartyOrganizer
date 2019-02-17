//
//  NetworkManager.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit


/// Metwork Manager
class NetworkManager: NSObject {
    
    /// Shared instance
    static let shared = NetworkManager()
    
    /// Perform GET request
    ///
    /// - Parameter url: URL address
    /// - Returns: Request result encapsulated in a Promise
    @discardableResult func performGetRequest(url: URL) -> Promise<Any> {
        return Promise { handler in
            Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
                .validate()
                .responseJSON(completionHandler: { dataResponse in
                    switch dataResponse.result {
                    case .success(let result):
                        handler.fulfill(result)
                    case .failure(let error):
                        handler.reject(error)
                    }
                })
        }
    }
    
}

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

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    @discardableResult func performGetRequest(urlAddress: String) -> Promise<[[String: Any]]> {
        return Promise { handler in
            guard let url = URL(string: urlAddress) else {
                handler.reject(PartyOrganizerError.invalidUrl)
                return
            }
            Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
                .validate()
                .responseJSON(completionHandler: { dataResponse in
                    switch dataResponse.result {
                    case .success(let result):
                        if let response = result as? [[String: Any]] {
                            handler.fulfill(response)
                        } else {
                            handler.reject(PartyOrganizerError.invalidResponse)
                        }
                    case .failure(let error):
                        handler.reject(error)
                    }
                })
        }
    }
    
}

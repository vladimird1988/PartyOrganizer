//
//  CustomTypes.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation

enum PartyOrganizerError: Error, LocalizedError {
    case invalidUrl
    case invalidResponse
    case parseError
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .invalidUrl:
            return "Invalid url"
        case .parseError:
            return "Parse error"
        case .custom(let errorMessage):
            return errorMessage
        }
    }
}

typealias voidMethod = () -> Void

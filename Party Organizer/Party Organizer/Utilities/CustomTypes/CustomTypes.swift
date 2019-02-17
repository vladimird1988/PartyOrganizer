//
//  CustomTypes.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation

/// Custom enum for errors in the application
///
/// - invalidUrl: URL is invalid
/// - invalidResponse: Server response is invalid
/// - parseError: Some error happened durring parsing the data from the server
/// - custom: Custom error whih enables the developer to write custom localized description messge
enum PartyOrganizerError: Error, LocalizedError {
    case invalidUrl
    case invalidResponse
    case parseError
    case custom(String)
    
    /// Protocol variable for localized description
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

// MARK: - Typealiases for closures

/// Void method
typealias voidMethod = () -> Void
typealias intMethod = (Int) -> Void

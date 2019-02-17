//
//  AppStrings.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/17/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation


/// Enum used for handling keys all localized strings as resources
enum AppStrings: String{
    
    case partyName = "PartyName"
    case partyDateAndTime = "PartyDateAndTime"
    case name = "Name"
    case startDateAndTime = "StartDateAndTime"
    case error = "Error"
    case ok = "OK"
    case partyNameIsEmpty = "PartyNameIsEmpty"
    case partyNameIsTooShort = "PartyNameIsTooShort"
    case partyStartTimeIsNotSet = "PartyStartTimeIsNotSet"
    case partyDescriptionIsEmpty = "PartyDescriptionIsEmpty"
    case partyDescriptionIsTooShort = "PartyDescriptionIsTooShort"
    case parties = "Parties"
    case members = "Members"
    case partyDescription = "PartyDescription"
    case add = "Add"
    
    
    /// Returns localized string for a given key
    var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}

//
//  Date+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation

// MARK: - Date extension used for converting date to a string in a given format
extension Date {
    
    /// Returns date converted to a string in a given format
    ///
    /// - Parameter timeFormat: Format in which date should be displayed. Default is: "dd.MM.yyyy HH:mm"
    /// - Returns: Date converted to a string which is suitable for presenting
    func asString(timeFormat: String = "dd.MM.yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormat
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
}

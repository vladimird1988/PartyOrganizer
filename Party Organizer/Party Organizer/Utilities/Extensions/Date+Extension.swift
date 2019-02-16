//
//  Date+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation

extension Date {
    
    func asString(timeFormat: String = "dd.MM.yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormat
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
}

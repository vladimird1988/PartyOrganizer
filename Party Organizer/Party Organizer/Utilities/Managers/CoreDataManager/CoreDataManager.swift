//
//  CoreDataManager.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/14/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import CoreFoundation
import CoreData
import AERecord

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    func loadStack() {
        do {
            try AERecord.loadCoreDataStack()
        } catch {
            print(error)
        }
    }
    
    func saveContext() {
        AERecord.saveAndWait()
    }
    
}

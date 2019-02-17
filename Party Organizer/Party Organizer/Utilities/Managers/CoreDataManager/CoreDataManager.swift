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


/// CoreData Manager
class CoreDataManager {
    
    /// Shared instane
    static let shared = CoreDataManager()
    
    // MARK: - Basic methods for loading and saving CoreData stack / context
    
    /// Load stack
    func loadStack() {
        do {
            try AERecord.loadCoreDataStack()
        } catch {
            print(error)
        }
    }
    
    /// Save context
    func saveContext() {
        AERecord.saveAndWait()
    }
    
}

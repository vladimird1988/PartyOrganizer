//
//  HomeViewModel.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// Main app view model
class HomeViewModel: NSObject {

    /// Shared instance
    static let shared = HomeViewModel()
    
    /// Observer for changes in parties data
    var partiesObserver: Observable<AppData.DataEvent> {
        return AppData.shared.dataEventObserver
    }
    
    /// Fetch all members from the backend
    func getMembers() {
        BackendManager.sharedInstance.getMembers()
            .done {
                if let membersDataArray = $0["profiles"] as? [[String: Any]] {
                    let members = membersDataArray.map { Member.createOrUpdate(data: $0) }
                    members.forEach { $0.save() }
                    AppData.shared.members.accept(members)
                }
            }
            .cauterize()
    }
    
    /// PartyViewModel for party at specific position
    ///
    /// - Parameter position: Position of single party in array of parties
    /// - Returns: PartyViewModel instance
    func partyViewModel(at position: Int) -> PartyViewModel {
        return PartyViewModel(party: AppData.shared.parties.value[position])
    }
    
    
    /// Delete party at specific position
    ///
    /// - Parameter position: Position of single party in array of parties
    func deleteParty(at position: Int) {
        AppData.shared.deleteParty(at: position)
    }
    
}

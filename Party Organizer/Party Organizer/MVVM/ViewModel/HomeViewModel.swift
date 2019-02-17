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

class HomeViewModel: NSObject {

    static let shared = HomeViewModel()
    
    func getMembers() {
        BackendManager.sharedInstance.getMembers()
            .done { [weak self] in
                print("Members: \($0)")
                if let membersDataArray = $0["profiles"] as? [[String: Any]] {
                    let members = membersDataArray.map { Member.createOrUpdate(data: $0) }
                    members.forEach { $0.save() }
                    AppData.shared.members.accept(members)
                    print("Members parsed")
                }
            }
            .cauterize()
    }
    
    var partiesObserver: Observable<AppData.DataEvent> {
        return AppData.shared.dataEventObserver
    }
    
    func partyViewModel(at position: Int) -> PartyViewModel {
        return PartyViewModel(party: AppData.shared.parties.value[position])
    }
    
    func deleteParty(at position: Int) {
        AppData.shared.deleteParty(at: position)
    }
    
}

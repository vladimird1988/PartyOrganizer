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
    
    let appData = AppData.shared
    
    let selectedParties = BehaviorRelay<[Party]>(value: [])
    
    func getMembers() {
        BackendManager.sharedInstance.getMembers()
            .done { [weak self] in
                print("Members: \($0)")
                if let membersDataArray = $0["profiles"] as? [[String: Any]] {
                    let members = membersDataArray.map { Member(data: $0) }
                    members.forEach { $0.save() }
                    self?.appData.members.accept(members)
                    print("Members parsed")
                }
            }
            .cauterize()
    }
    
    var partiesObserver: Observable<AppData.DataEvent> {
        return appData.dataEventObserver
    }
    
    func select(party: Party) {
        selectedParties.accept(selectedParties.value + [party])
    }
    
    func deselect(party: Party) {
        selectedParties.accept(selectedParties.value.filter { $0.partyId != party.partyId })
    }
    
    func partyViewModel(at position: Int) -> PartyViewModel {
        let partyViewModel = PartyViewModel(party: appData.parties.value[position])
        partyViewModel.homeViewModel = self
        return partyViewModel
    }
    
    func deleteParty(at position: Int) {
        appData.deleteParty(at: position)
    }
    
}

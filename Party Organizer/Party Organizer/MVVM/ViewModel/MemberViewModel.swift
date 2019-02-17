//
//  MemberViewModel.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/15/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MemberViewModel: NSObject {

    var partyViewModel: PartyViewModel?
    
    let parties = BehaviorRelay<[Party]>(value: [])
    
    let isSelected = BehaviorRelay<Bool>(value: false)
    
    let member: Member
    
    init(member: Member) {
        self.member = member
        self.parties.accept(member.parties)
        
    }
    
    var fullName: String {
        return member.username
    }
    
    var gender: String {
        return member.gender
    }
    
    var email: String {
        return member.email
    }
    
    var about: String {
        return member.aboutMe
    }
    
    var imageUrl: String {
        return member.photo
    }
    
    func makeACall() {
        let phoneNumber = member.cell
        let phoneNumberRegex = "^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\\s\\./0-9]*$"
        let cleanPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        guard
            NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex).evaluate(with: phoneNumber),
            let url = URL(string: "tel://\(cleanPhoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
                    return
            }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func select(party: Party) {
        parties.accept(Array(Set(parties.value + [party])))
        save()
    }
    
    func deselect(party: Party) {
        parties.accept(Array(Set(parties.value.filter { $0.partyId != party.partyId })))
        save()
    }
    
    private func save() {
        member.parties = parties.value
        member.save()
    }
    
    var allParties: [Party] {
        return AppData.shared.parties.value
    }
    
    func partyViewModel(at position: Int) -> PartyViewModel {
        let party = AppData.shared.parties.value[position]
        let partyViewModel = PartyViewModel(party: party)
        partyViewModel.isSelected.accept(member.parties.contains(party))
        partyViewModel.memberViewModel = self
        return partyViewModel
    }
    
    var selectionObserver: Observable<Bool> {
        return isSelected.asObservable().do(onNext: { [weak self] in
            guard let member = self?.member else { return }
            if $0 {
                self?.partyViewModel?.select(member: member)
            } else {
                self?.partyViewModel?.deselect(member: member)
            }
        })
    }
    
}

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

/// Member ViewModel
class MemberViewModel: NSObject {

    /// Reference to PartyViewModel instnace if we have selection mode (adding member to a party)
    var partyViewModel: PartyViewModel?
    
    /// parties
    let parties = BehaviorRelay<[Party]>(value: [])
    
    /// Defines if a member is selected for adding to aparty during a selection mode
    let isSelected = BehaviorRelay<Bool>(value: false)
    
    /// Member instance
    let member: Member
    
    /// Constructor
    ///
    /// - Parameter member: Member instance
    init(member: Member) {
        self.member = member
        self.parties.accept(member.parties)
        
    }
    
    
    /// Full name / username
    var fullName: String {
        return member.username
    }
    
    /// Gender
    var gender: String {
        return member.gender
    }
    
    /// Email
    var email: String {
        return member.email
    }
    
    /// About
    var about: String {
        return member.aboutMe
    }
    
    /// Image url
    var imageUrl: String {
        return member.photo
    }
    
    /// Make a phone call
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
    
    /// Select a party
    ///
    /// - Parameter party: Party instance
    func select(party: Party) {
        parties.accept(Array(Set(parties.value + [party])))
        save()
    }
    
    /// Deselect a party
    ///
    /// - Parameter party: Party intance
    func deselect(party: Party) {
        parties.accept(Array(Set(parties.value.filter { $0.partyId != party.partyId })))
        save()
    }
    
    /// Save membe in CoreData
    private func save() {
        member.parties = parties.value
        member.save()
    }
    
    
    /// All parties
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

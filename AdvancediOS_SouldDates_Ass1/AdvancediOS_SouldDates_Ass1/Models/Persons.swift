//
//  Persons.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation

enum ProfileError: Error {
    case underAgeException
    case noMatchesFound
    case caseSelectionNotListed(message: String)
    case emptyTextFields
}

enum Gender: String, CaseIterable, Identifiable, Decodable {
    case female
    case male
    case nonbinary
    case transgender
    case other
    
    var id: Self {self }
}

enum InterestedIn: String, CaseIterable, Identifiable, Decodable {
    case men
    case women
    case both
    case other
    case all
    
    var id: Self {self}
}

enum DisabilitySeverity: String, CaseIterable, Identifiable, Decodable {
    case mild
    case moderate
    case severe
    
    var id: Self { self }
}

enum DisabilityPreference: String, CaseIterable, Identifiable, Decodable {
    case withDisability = "People with disabilities"
    case withoutDisability = "People without disabilities"
    case openMinded = "I am open minded!"
    
    var id: Self {self}
}

protocol Person: Identifiable, Decodable {
    var id: UUID {get set}
    var screenName: String {get set}
}
/*
protocol MatchSeekerUser: Identifiable {
    var id: UUID {get set}
    var dateOfBirth: Date {get set}
    var screenName: String {get set}
    var bio: String {get set}
    var hobbies: String {get set}
    var favouriteMusic: String {get set}
    var isScammer: Bool {get set}
    var gender: Gender {get set}
    var datingPreference: DatingPreference {get set}
    var disability: Disability? {get set}
    var policeCheck: PoliceCheck? {get set}
    var proofOfAge: ProofOfAge? {get set}
    var refereeCheck: RefereeCheck? {get set}
    
    //these are the functions where match seekers can upload their background checks.
    mutating func setPoliceCheck(policeCheck: PoliceCheck)
    mutating func setRefereeCheck(referee: RefereeCheck)
    mutating func setProofOfAge(proofOfAge: ProofOfAge)
    mutating func toggleScammer()
    
}*/
/*
extension MatchSeekerUser {
    mutating func setPoliceCheck(policeCheck: PoliceCheck) {
        self.policeCheck = policeCheck
    }
    
    mutating func setRefereeCheck(referee: RefereeCheck)
    {
        self.refereeCheck = refereeCheck
    }
    
    mutating func setProofOfAge(proofOfAge: ProofOfAge)
    {
        self.proofOfAge = proofOfAge
    }
    
    mutating func toggleScammer() {
        if isScammer == false {
            isScammer = true
        }
        else{
            isScammer = false
        }
    }
}*/

struct Disability: Identifiable, Decodable {
    var disabilities: String
    var severeity: DisabilitySeverity
    var id: UUID = UUID()
}

struct DatingPreference: Decodable {
    var interestedIn: InterestedIn
    var disabilityPreference: DisabilityPreference
    var discloseMyDisability: Bool
}

struct AnyMatchSeeker {
    var id = UUID()
    var screenName: String
    
    init(id: UUID = UUID(), screenName: String) {
        self.id = id
        self.screenName = screenName
    }
}




struct Admin: Person {
    var id: UUID = UUID()
    var screenName: String
    
}

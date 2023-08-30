//
//  Persons.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation

enum ProfileError: Error {
    case underAgeException
}

protocol Person {
    var id: UUID {get set}
    var screenNamt: String {get set}
}

protocol MatchSeekerUser: Identifiable {
    var id: UUID {get set}
    var dateOfBirth: Date {get set}
    var screenName: String {get set}
    var bio: String {get set}
    var hobbies: String {get set}
    var favouriteMusic: String {get set}
    var isScammer: Bool {get set}
    var gender: Gender {get set}
    var interestedIn: InterestedIn {get set}
    var policeCheck: PoliceCheck? {get set}
    var proofOfAge: ProofOfAge? {get set}
    var refereeCheck: RefereeCheck? {get set}
    var disability: Disability? {get set}
    var isDisabled: Bool {get set}
    var discloseDisability: Bool {get set}
    
    //these are the functions where match seekers can upload their background checks.
    mutating func setPoliceCheck(policeCheck: PoliceCheck)
    mutating func setRefereeCheck(referee: RefereeCheck)
    mutating func setProofOfAge(proofOfAge: ProofOfAge)
    mutating func toggleScammer()
    
}

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
}

struct Disability {
    var disabilities: String
    var severeity: String
}

struct AnyMatchSeeker {
    var id = UUID()
    var screenName: String
    
    init(id: UUID = UUID(), screenName: String) {
        self.id = id
        self.screenName = screenName
    }
}

class AllMatchSeekers {
    var matchSeekers: [MatchSeeker]
    
    init(matchSeekers: [MatchSeeker]) {
        self.matchSeekers = matchSeekers
    }
}

struct MatchSeeker: MatchSeekerUser {
    var id: UUID = UUID()
    var screenName: String
    var hobbies: String
    var gender: Gender
    var dateOfBirth: Date
    var bio: String
    var favouriteMusic: String
    var policeCheck: PoliceCheck?
    var proofOfAge: ProofOfAge?
    var refereeCheck: RefereeCheck?
    var disability: Disability?
    var isDisabled: Bool
    var discloseDisability: Bool
    var isScammer: Bool
    var interestedIn: InterestedIn
    
    init(screenName: String, hobbies: String, gender: Gender, dateOfBirth: Date, bio: String, favourteMusic: String, interestedIn: InterestedIn, disability: Disability? = nil) {
        self.screenName = screenName
        self.hobbies = hobbies
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.bio = bio
        self.favouriteMusic = favourteMusic
        self.interestedIn = interestedIn
        self.disability = disability
        self.policeCheck = nil
        self.refereeCheck = nil
        self.discloseDisability = false
        self.proofOfAge = nil
        self.isScammer = false
        self.isDisabled = false
    }
    
}

struct Admin: Person {
    var id: UUID = UUID()
    var screenNamt: String
    
}

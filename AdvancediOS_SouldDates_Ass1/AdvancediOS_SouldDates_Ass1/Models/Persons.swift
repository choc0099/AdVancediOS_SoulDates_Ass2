//
//  Persons.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation

enum ProfileError: Error {
    case underAgeException
    case noMatchesFound(message: String)
    case caseSelectionNotListed(message: String)
}

enum Gender: String, CaseIterable, Identifiable {
    case female
    case male
    case nonbinary
    case transgender
    case other
    
    var id: Self {self }
}

enum InterestedIn {
    case men
    case women
    case both
    case other
    case all
}

enum DisabilityPreference: String, Identifiable {
    case withDisability = "With Disabilty"
    case withoutDisability = "Without Disability"
    case openMinded = "I am open minded"
    
    var id: Self {self}
}

protocol Person: Identifiable {
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

struct Disability {
    var disabilities: String
    var severeity: String
}

struct DatingPreference {
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


struct MatchSeeker: Person {
    var id: UUID = UUID()
    var screenName: String
    var hobbies: String
    var gender: Gender
    var datingPreference: DatingPreference
    var dateOfBirth: Date
    var bio: String
    var favouriteMusic: String
    var policeCheck: PoliceCheck?
    var proofOfAge: ProofOfAge?
    var refereeCheck: RefereeCheck?
    var disability: Disability?
    var isScammer: Bool
    
    init(screenName: String, hobbies: String, gender: Gender, dateOfBirth: Date, bio: String, favourteMusic: String, datingPreference: DatingPreference, disability: Disability? = nil) throws {
        self.screenName = screenName
        self.hobbies = hobbies
        self.gender = gender
        if DateManager.isUnderAge(birthDate: dateOfBirth) == true {
            self.dateOfBirth = dateOfBirth
        }
        else {
            throw ProfileError.underAgeException
        }
        self.bio = bio
        self.favouriteMusic = favourteMusic
        self.datingPreference = datingPreference
        self.disability = disability
        self.policeCheck = nil
        self.refereeCheck = nil
        self.proofOfAge = nil
        self.isScammer = false
    }
    
    //functions for getters and setters
    mutating func setPoliceCheck(policeCheck: PoliceCheck) {
        self.policeCheck = policeCheck
    }
    
    mutating func setRefereeCheck(referee: RefereeCheck)
    {
        self.refereeCheck = referee
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

struct Admin: Person {
    var id: UUID = UUID()
    var screenName: String
    
}

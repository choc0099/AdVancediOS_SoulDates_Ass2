//
//  MatchSeeker.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 4/9/2023.
//

import Foundation

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
    
    init(screenName: String, hobbies: String, gender: Gender, dateOfBirth: Date, bio: String, favourteMusic: String, datingPreference: DatingPreference,
         disability: Disability? = nil) {
        self.screenName = screenName
        self.hobbies = hobbies
        self.gender = gender
        self.dateOfBirth = dateOfBirth
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
    
    mutating func editProfile(screenName: String, gender: Gender, dateOfBirth: Date, bio: String, hobbies: String, favouriteMusic: String) {
        self.screenName = screenName
        self.dateOfBirth = dateOfBirth
        self.bio = bio
        self.gender = gender
        self.hobbies = hobbies
        self.favouriteMusic = favouriteMusic
    }
    
    func getHeadlineText() -> String? {
        var disabledText: String?
        if let haveDisability = disability {
            if datingPreference.discloseMyDisability {
                disabledText = "\(haveDisability.disabilities), \(haveDisability.severeity.rawValue.capitalized)"
            }
        }
        else {
            if datingPreference.disabilityPreference == .openMinded
            {
                disabledText = "Positive about disabled."
            }
        }
        return disabledText
    }
}

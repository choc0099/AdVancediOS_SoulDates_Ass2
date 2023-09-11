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
    var backgroundCheck: BackgroundCheck?
    var disability: Disability?
    var isScammer: Bool
    var imageName: String?
    
    init(screenName: String, hobbies: String, gender: Gender, dateOfBirth: Date, bio: String, favourteMusic: String, datingPreference: DatingPreference,
         disability: Disability? = nil, imageName: String? = nil) {
        self.screenName = screenName
        self.hobbies = hobbies
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.bio = bio
        self.favouriteMusic = favourteMusic
        self.datingPreference = datingPreference
        self.disability = disability
        self.isScammer = false
        self.backgroundCheck = nil
        self.imageName = imageName
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
    
    mutating func setBackgroundCheck(backgroundCheck: BackgroundCheck?) {
        self.backgroundCheck = backgroundCheck
    }
    
    
}

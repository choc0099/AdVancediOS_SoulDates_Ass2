//
//  MatchSeeker.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 4/9/2023.
//

import Foundation

//refer to DatingPreferences struct for reasons why i chose to use enums.
enum Gender: String, CaseIterable, Identifiable, Codable {
    case female
    case male
    case nonbinary
    case transgender
    case other
    var id: Self {self }
}

//this a a matchSeeker struct that comforms to the Person protocol and Datable protocol i have created.
//it also comforms to codeable for userDefaults.
struct MatchSeeker: Person, Codable, Dateable {
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
    
    //toggles the scammer status of a matchSeeker when reporting a scam.
    mutating func toggleScammer() {
        if isScammer == false {
            isScammer = true
        }
        else{
            isScammer = false
        }
    }
    
    //updates the matchSeeker's basic profile details.
    mutating func editProfile(screenName: String, gender: Gender, dateOfBirth: Date, bio: String, hobbies: String, favouriteMusic: String) {
        self.screenName = screenName
        self.dateOfBirth = dateOfBirth
        self.bio = bio
        self.gender = gender
        self.hobbies = hobbies
        self.favouriteMusic = favouriteMusic
    }
    
    //returns a string to add on their profile as a headline whether is disability their disabilities or something else.
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
    
    //initialises or nils the background check of a match seeker.
    mutating func setBackgroundCheck(backgroundCheck: BackgroundCheck?) {
        self.backgroundCheck = backgroundCheck
    }
}

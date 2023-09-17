//
//  DatingPreference.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 8/9/2023.
//

import Foundation

//I have decided to use enums for interestedIn, disability severity and disability preferences
//The enums  makes it easier to access as they have to select an item instead of typing it manuelly.
//and it makes it convienient to filter matches.
//the enums also comforms to the Caseiterable protocol so it can return be capitilized when viewing enums casses in SwiftUI views.
enum DisabilitySeverity: String, CaseIterable, Identifiable, Codable {
    case mild
    case moderate
    case severe
    var id: Self { self } // used to identify an enum case when looping through enums in SwiftUI views.
}

enum InterestedIn: String, CaseIterable, Identifiable, Codable {
    case men
    case women
    case both
    case other
    case all
    var id: Self {self}
}

//An enum that choses who wthey want to date based on their disability status.
enum DisabilityPreference: String, CaseIterable, Identifiable, Codable {
    case withDisability = "People with disabilities"
    case withoutDisability = "People without disabilities"
    case openMinded = "I am open minded!"
    
    var id: Self {self}
}

//this is a dating prefernce struct that allows match seekers to confiugre their dating criteria.
struct DatingPreference: Codable {
    var interestedIn: InterestedIn
    var disabilityPreference: DisabilityPreference
    //this is a setting that discloses people's disabilities if they want to share it with others on their profiles.
    var discloseMyDisability: Bool
    //this is a setting for people with disabilities to see more matches which could lead to rejection.
    var riskGettingRejected: Bool
    //this is for the age ranges of what the match seeker is looking for.
    var minAge: Int
    var maxAge: Int
    
    init(interestedIn: InterestedIn, disabilityPreference: DisabilityPreference, discloseMyDisability: Bool, minAge: Int, maxAge: Int) {
        self.interestedIn = interestedIn
        self.disabilityPreference = disabilityPreference
        self.discloseMyDisability = discloseMyDisability
        self.riskGettingRejected = false
        self.minAge = minAge
        self.maxAge = maxAge
    }
    
    //used to update general dating prefernces
    mutating func updateDatingPrefernces(interstedIn: InterestedIn, disabilityPreferences: DisabilityPreference, minAge: Int, maxAge: Int) {
        self.interestedIn = interstedIn
        self.disabilityPreference = disabilityPreferences
        self.minAge = minAge
        self.maxAge = maxAge
    }
    
    //this is specific to disability
    mutating func updateDisabilityRelatedPreference(discloseDisability: Bool, riskRejections: Bool) {
        self.discloseMyDisability = discloseDisability
        self.riskGettingRejected = riskRejections
    }
}

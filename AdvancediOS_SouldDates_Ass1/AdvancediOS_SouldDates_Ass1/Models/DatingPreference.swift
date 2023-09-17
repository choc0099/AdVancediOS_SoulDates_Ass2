//
//  DatingPreference.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 8/9/2023.
//

import Foundation
enum DisabilitySeverity: String, CaseIterable, Identifiable, Codable {
    case mild
    case moderate
    case severe
    
    var id: Self { self }
}
struct DatingPreference: Codable {
    var interestedIn: InterestedIn
    var disabilityPreference: DisabilityPreference
    var discloseMyDisability: Bool
    //this is a setting for people with disabilities to see more matches which could lead to rejection.
    var riskGettingRejected: Bool
    //this is for the age ranges of the what matchSeeker they want.
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

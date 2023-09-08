//
//  DatingPreference.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 8/9/2023.
//

import Foundation
enum DisabilitySeverity: String, CaseIterable, Identifiable, Decodable {
    case mild
    case moderate
    case severe
    
    var id: Self { self }
}
struct DatingPreference: Decodable {
    var interestedIn: InterestedIn
    var disabilityPreference: DisabilityPreference
    var discloseMyDisability: Bool
    //this is a setting for people with disabilities to see more matches which could lead to rejection.
    var riskGettingRejected: Bool
    
    init(interestedIn: InterestedIn, disabilityPreference: DisabilityPreference, discloseMyDisability: Bool) {
        self.interestedIn = interestedIn
        self.disabilityPreference = disabilityPreference
        self.discloseMyDisability = discloseMyDisability
        self.riskGettingRejected = false
    }
    
    mutating func updateDatingPrefernces(interstedIn: InterestedIn, disabilityPreferences: DisabilityPreference) {
        self.interestedIn = interstedIn
        self.disabilityPreference = disabilityPreferences
        
    }
    
    mutating func updateDisabilityRelatedPreference(discloseDisability: Bool, riskRejections: Bool) {
        self.discloseMyDisability = discloseDisability
        self.riskGettingRejected = riskRejections
    }
}

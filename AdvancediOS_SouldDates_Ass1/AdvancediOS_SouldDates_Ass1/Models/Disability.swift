//
//  Disability.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 7/9/2023.
//

import Foundation
//this is a struct where a match seeker can put their disability related details.
//on the Match seeker struct, it is an optinal value because my target audience for this app is for people with and without disabilities.
struct Disability: Codable {
    var disabilities: String
    var severeity: DisabilitySeverity
    var id: UUID = UUID()
    
    //updates their disability related details when in the settings views.
    mutating func updateDisabilityDetails(disabilities: String, disabilitySeverity: DisabilitySeverity) {
        self.disabilities = disabilities
        self.severeity = disabilitySeverity
    }
}

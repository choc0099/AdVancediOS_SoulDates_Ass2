//
//  Disability.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 7/9/2023.
//

import Foundation
struct Disability: Identifiable, Decodable {
    var disabilities: String
    var severeity: DisabilitySeverity
    var id: UUID = UUID()
    
    mutating func updateDisabilityDetails(disabilities: String, disabilitySeverity: DisabilitySeverity) {
        self.disabilities = disabilities
        self.severeity = disabilitySeverity
    }
}

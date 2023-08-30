//
//  BackgroundCheck.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation


struct PoliceCheck: Verifiable {
    var id: UUID = UUID()
    var dateIssued: Date
    var expiryDate: Date
    var isCriminalRecord: Bool
    
}

struct ProofOfAge: Verifiable {
    var id: UUID = UUID()
    var dateIssued: Date
    var expiryDate: Date
    var issuer: String
    var proofOfIdNumber: String
    var legalFirstName: String
    var legalLastName: String
    var streetAddress: String
}

struct RefereeCheck: Verifiable {
    var id: UUID = UUID()
    var dateIssued: Date
    var expiryDate: Date
    var refereeName: String
    var description: String
}

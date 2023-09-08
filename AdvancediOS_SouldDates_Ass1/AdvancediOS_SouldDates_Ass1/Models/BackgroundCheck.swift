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
    var description: String
    
    mutating func updatePoliceCheckDetails(dateIssued: Date, expiryDate: Date, description: String)
    {
        self.dateIssued = dateIssued
        self.expiryDate = expiryDate
        self.description = description
    }
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

struct BackgroundCheck: Decodable {
    var policeCheck: PoliceCheck?
    var proofOfAge: ProofOfAge?
    var refereeCheck: RefereeCheck?
    
    //functions for getters and setters
    mutating func setPoliceCheck(policeCheck: PoliceCheck?) {
        self.policeCheck = policeCheck
    }
    
    mutating func setRefereeCheck(referee: RefereeCheck?)
    {
        self.refereeCheck = referee
    }
    
    mutating func setProofOfAge(proofOfAge: ProofOfAge?)
    {
        self.proofOfAge = proofOfAge
    }
    
}

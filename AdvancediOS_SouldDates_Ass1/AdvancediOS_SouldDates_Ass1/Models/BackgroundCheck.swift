//
//  BackgroundCheck.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation

//this struct contains all background check instances.
struct BackgroundCheck: Codable {
    var policeCheck: PoliceCheck?
    var proofOfAge: ProofOfAge?
    var refereeCheck: RefereeCheck?
    
    //functions for setters
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

struct PoliceCheck: Verifiable, Codable {
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

struct ProofOfAge: Verifiable, Codable {
    var id: UUID = UUID()
    var dateIssued: Date
    var expiryDate: Date
    var issuer: String
    var proofOfIdNumber: String
    var legalFirstName: String
    var legalLastName: String
    var streetAddress: String
    var dateOfBirth: Date
    
    mutating func updateDetails(dateIssued: Date, expiryDate: Date, issuer: String, proofOfIdNumber: String, legalFirstName: String, legalLastName: String, streetAddress: String, dateOfBirth: Date)
    {
        self.dateIssued = dateIssued
        self.dateOfBirth = dateOfBirth
        self.expiryDate = expiryDate
        self.issuer = issuer
        self.legalFirstName = legalFirstName
        self.legalLastName = legalLastName
        self.proofOfIdNumber = proofOfIdNumber
        self.streetAddress = streetAddress
    }
}

struct RefereeCheck: Verifiable, Codable {
    var id: UUID = UUID()
    var dateIssued: Date
    var expiryDate: Date
    var refereeName: String
    var description: String
    
    //this will be used to update the refereeCheck
    mutating func updateRefereeCheck(dateIssued: Date, expiryDate: Date, description: String, refereeName: String) {
        self.dateIssued = dateIssued
        self.expiryDate = expiryDate
        self.description = description
        self.refereeName = refereeName
    }
}

//adds additional functions related to background checks on the main class
extension SoulDatesMain {
    //this will be used to set or nil a background check.
    func manageBackgroundChecks(currentMatchSeekr: MatchSeeker, backgroundCheck: BackgroundCheck?) throws
    {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeekr.id})
        {
            self.matchSeekers[index].setBackgroundCheck(backgroundCheck: backgroundCheck)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    //this will be used to set or nil a police check.
    func managePoliceCheck(currentMatchSeeker: MatchSeeker, policeCheck: PoliceCheck?) throws {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id}) {
            self.matchSeekers[index].backgroundCheck?.setPoliceCheck(policeCheck: policeCheck)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    //this will be used to set or nil a proof of age identification.
    func manageProofOfAgeCheck(currentMatchSeeker: MatchSeeker, proofOfAge: ProofOfAge?) throws{
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id}) {
            
            self.matchSeekers[index].backgroundCheck?.setProofOfAge(proofOfAge: proofOfAge)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    //this will be used to set or nil a referee check.
    func manageRefereeCheck(currentMatchSeeker: MatchSeeker, refereeCheck: RefereeCheck?) throws {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id}) {
            self.matchSeekers[index].backgroundCheck?.setRefereeCheck(referee: refereeCheck)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    //this will be used to update existing policeCheckDetails if they have already provided us with that.
    func updatePoliceCheckDetails(currentMatchSeeker: MatchSeeker, issueDate: Date, expiryDate: Date, description: String) throws
    {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id}) {
            self.matchSeekers[index].backgroundCheck?.policeCheck?.updatePoliceCheckDetails(dateIssued: issueDate, expiryDate: expiryDate, description: description)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    //same as above function but for proof of age details.
    func updateProofOfAgeDetails(currentMatchSeeker: MatchSeeker, legalFirstName: String, legalLastName: String, dateIssued: Date, expiryDate: Date, streetAddress: String, dateOfBirth: Date, issuer: String, proofOfIdNumber: String) throws {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id})
        {
            //updates the proof of age details from the matchSeekers
            self.matchSeekers[index].backgroundCheck?.proofOfAge?.updateDetails(dateIssued: dateIssued, expiryDate: expiryDate, issuer: issuer, proofOfIdNumber: proofOfIdNumber, legalFirstName: legalFirstName, legalLastName: legalLastName, streetAddress: streetAddress, dateOfBirth: dateOfBirth)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    //same as above function but for referee check details
    func updateRefereeDetails(currentMatchSeeker: MatchSeeker, refereeName: String, description: String, dateIssued: Date, expiryDate: Date) throws {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id}) {
            self.matchSeekers[index].backgroundCheck?.refereeCheck?.updateRefereeCheck(dateIssued: dateIssued, expiryDate: expiryDate, description: description, refereeName: refereeName)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
}

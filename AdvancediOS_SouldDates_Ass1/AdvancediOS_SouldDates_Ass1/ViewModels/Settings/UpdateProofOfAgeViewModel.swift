//
//  UpdateProofOfAgeViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import Foundation
import RegexBuilder

class UpdateProofOfAgeViewModel: ObservableObject {
    @Published var isProofOfAge: Bool = false
    @Published var proofOfAgeIdNumber: String = ""
    @Published var dateIssued: Date = Date()
    @Published var expiryDate: Date = Date()
    @Published var issuer: String = ""
    @Published var legalFirstName: String = ""
    @Published var legalLastName: String = ""
    @Published var address: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var session: Session = Session()
    @Published var soulDatesMain: SoulDatesMain = SoulDatesMain()
    
    func validate() throws {
        let numericOnly = try Regex("[0-9]+")
        
        if isProofOfAge {
            guard try !(numericOnly.firstMatch(in: proofOfAgeIdNumber) == nil) else {
                throw ProfileError.invalidIDNumber
            }
            
            guard !DateManager.isUnderAge(birthDate: dateOfBirth) else {
                throw ProfileError.underAgeException
            }
        }
        
    }
    
    
    //resets the proof of age details from the VM side if the user decides to no longer have their proof of age details.
    func resetVM() {
        self.proofOfAgeIdNumber = ""
        self.dateIssued = Date.now
        self.expiryDate = Date.now
        self.issuer = ""
        self.legalFirstName = ""
        self.legalLastName = ""
        self.address = ""
        self.dateOfBirth = Date.now
    }
    
}

//
//  UpdateProofOfAgeView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import SwiftUI

struct UpdateProofOfAgeView: View {
    @ObservedObject var updateProofOfAge: UpdateProofOfAgeViewModel
    @EnvironmentObject var session: Session
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Proof of Age Check", isOn: $updateProofOfAge.isProofOfAge)
                }
                
                if updateProofOfAge.isProofOfAge {
                    Section(content: {
                        HStack () {
                            Text("ID Number").frame(width: 100, alignment: .leading)
                            Spacer()
                            TextField("ID Number", text: $updateProofOfAge.proofOfAgeIdNumber)
                        }
                        HStack () {
                            Text("Issuer").frame(width: 100, alignment: .leading)
                            Spacer()
                            TextField("Issuer", text: $updateProofOfAge.issuer)
                        }
                        DatePicker("Date issued:", selection: $updateProofOfAge.dateIssued, displayedComponents: [.date])
                        DatePicker("Expiry Date", selection: $updateProofOfAge.expiryDate, displayedComponents: [.date])
                    }, header: {
                        Text("Proof of Age Details")
                    }, footer: {
                        Text("This is only a prototype, no API's are being used to verify proof of age.")
                    })
                    Section("Personal Details") {
                        HStack() {
                            Text("First Name").frame(width: 100, alignment: .leading)
                            TextField("First Name", text: $updateProofOfAge.legalFirstName)
                        }
                        HStack {
                            Text("Last Name").frame(width: 100, alignment: .leading)
                            TextField("Last Name", text: $updateProofOfAge.legalLastName)
                        }
                        DatePicker("Date of birth", selection: $updateProofOfAge.dateOfBirth, displayedComponents: [.date])
                        
                    }
                    Section("Address") {
                        TextEditor(text: $updateProofOfAge.address)
                    }
                }
            }
        }
    }
    
    func processData() throws {
        let matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        
        //check if they declared that they have a proofOfAge check
        if updateProofOfAge.isProofOfAge {
            if matchSeeker.backgroundCheck?.proofOfAge != nil {
               try soulDatesMain.updateProofOfAgeDetails(currentMatchSeeker: matchSeeker, legalFirstName: updateProofOfAge.legalFirstName, legalLastName: updateProofOfAge.legalLastName, dateIssued: updateProofOfAge.dateIssued, expiryDate: updateProofOfAge.expiryDate, streetAddress: updateProofOfAge.address, dateOfBirth: updateProofOfAge.dateOfBirth, issuer: updateProofOfAge.issuer, proofOfIdNumber: updateProofOfAge.proofOfAgeIdNumber)
            }
            else if matchSeeker.backgroundCheck?.proofOfAge == nil {
              try initializeProofOfAge(matchSeeker: matchSeeker)
            } // checks if it is the first background check.
            else {
                try soulDatesMain.manageBackgroundChecks(currentMatchSeekr: matchSeeker, backgroundCheck: BackgroundCheck())
                try initializeProofOfAge(matchSeeker: matchSeeker)
            }
        }
        else {
           try soulDatesMain.manageProofOfAgeCheck(currentMatchSeeker: matchSeeker, proofOfAge: nil)
        }
    }
    
    private func initializeProofOfAge(matchSeeker: MatchSeeker) throws {
        try soulDatesMain.manageProofOfAgeCheck(currentMatchSeeker: matchSeeker, proofOfAge: ProofOfAge(dateIssued: updateProofOfAge.dateIssued, expiryDate: updateProofOfAge.expiryDate, issuer: updateProofOfAge.issuer, proofOfIdNumber: updateProofOfAge.proofOfAgeIdNumber, legalFirstName: updateProofOfAge.legalLastName, legalLastName: updateProofOfAge.legalLastName, streetAddress: updateProofOfAge.address, dateOfBirth: updateProofOfAge.dateOfBirth))
    }
}

struct UpdateProofOfAgeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProofOfAgeView(updateProofOfAge: UpdateProofOfAgeViewModel())
    }
}

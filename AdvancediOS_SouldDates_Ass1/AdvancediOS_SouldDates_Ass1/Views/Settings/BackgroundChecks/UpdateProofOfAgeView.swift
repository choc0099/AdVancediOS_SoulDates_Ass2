//
//  UpdateProofOfAgeView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import SwiftUI

struct UpdateProofOfAgeView: View {
    @ObservedObject var updateProofOfAgeVM: UpdateProofOfAgeViewModel
    @EnvironmentObject var session: Session
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @State private var navActive: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @Binding var isOnSession: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Proof of Age Check", isOn: $updateProofOfAgeVM.isProofOfAge)
                }
                
                if updateProofOfAgeVM.isProofOfAge {
                    Section(content: {
                        HStack {
                            Text("ID Number").frame(width: 100, alignment: .leading)
                            Spacer()
                            TextField("ID Number", text: $updateProofOfAgeVM.proofOfAgeIdNumber)
                        }
                        HStack {
                            Text("Issuer").frame(width: 100, alignment: .leading)
                            Spacer()
                            TextField("Issuer", text: $updateProofOfAgeVM.issuer)
                        }
                        DatePicker("Date issued:", selection: $updateProofOfAgeVM.dateIssued, displayedComponents: [.date])
                        DatePicker("Expiry Date", selection: $updateProofOfAgeVM.expiryDate, displayedComponents: [.date])
                    }, header: {
                        Text("Proof of Age Details")
                    }, footer: {
                        Text("This is only a prototype, no API's are being used to verify proof of age.")
                    })
                    Section("Personal Details") {
                        HStack() {
                            Text("First Name").frame(width: 100, alignment: .leading)
                            TextField("First Name", text: $updateProofOfAgeVM.legalFirstName)
                        }
                        HStack {
                            Text("Last Name").frame(width: 100, alignment: .leading)
                            TextField("Last Name", text: $updateProofOfAgeVM.legalLastName)
                        }
                        DatePicker("Date of birth", selection: $updateProofOfAgeVM.dateOfBirth, displayedComponents: [.date])
                        
                    }
                    Section("Address") {
                        TextEditor(text: $updateProofOfAgeVM.address)
                    }
                }
            }.toolbar{
                Button {
                    do {
                        try updateProofOfAgeVM.validateDateOfBirth()
                        try processData()
                        navActive = true
                    }
                    catch ProfileError.underAgeException {
                        showAlert = true
                        alertTitle = "Under Age!"
                        alertMessage = "The proof of Age that was provided is under age to be continue using our app."
                    }
                    catch {
                        showAlert = true
                        alertTitle = "Something went wrong!"
                        alertMessage = "Unable to update proof of age details."
                    }
                } label: {
                    Text("Done")
                }
            }.navigationDestination(isPresented: $navActive, destination: {
                InSessionTabView(isOnSession: $isOnSession)
            }).onAppear {
                do {
                    try updateVM()
                }
                catch {
                    print("MatchSeeker does not exist.")
                }
            }
        }
    }
    //a function that updates the view model from the session once its being viewed.
    func updateVM() throws {
        let matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        if let matchSeekerProofOfAge = matchSeeker.backgroundCheck?.proofOfAge {
            updateProofOfAgeVM.isProofOfAge       = true
            updateProofOfAgeVM.address            = matchSeekerProofOfAge.streetAddress
            updateProofOfAgeVM.dateIssued         = matchSeekerProofOfAge.dateIssued
            updateProofOfAgeVM.dateOfBirth        = matchSeekerProofOfAge.dateOfBirth
            updateProofOfAgeVM.legalFirstName     = matchSeekerProofOfAge.legalFirstName
            updateProofOfAgeVM.legalLastName      = matchSeekerProofOfAge.legalLastName
            updateProofOfAgeVM.issuer             = matchSeekerProofOfAge.issuer
            updateProofOfAgeVM.proofOfAgeIdNumber = matchSeekerProofOfAge.proofOfIdNumber
        }
        else {
            updateProofOfAgeVM.isProofOfAge = false
        }
    }
    
    func processData() throws {
        let matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        
        //check if they declared that they have a proofOfAge check
        if updateProofOfAgeVM.isProofOfAge {
            if matchSeeker.backgroundCheck?.proofOfAge != nil {
               try soulDatesMain.updateProofOfAgeDetails(currentMatchSeeker: matchSeeker, legalFirstName: updateProofOfAgeVM.legalFirstName, legalLastName: updateProofOfAgeVM.legalLastName, dateIssued: updateProofOfAgeVM.dateIssued, expiryDate: updateProofOfAgeVM.expiryDate, streetAddress: updateProofOfAgeVM.address, dateOfBirth: updateProofOfAgeVM.dateOfBirth, issuer: updateProofOfAgeVM.issuer, proofOfIdNumber: updateProofOfAgeVM.proofOfAgeIdNumber)
            }
            else if matchSeeker.backgroundCheck?.proofOfAge == nil && matchSeeker.backgroundCheck != nil {
              try initialiseProofOfAge(matchSeeker: matchSeeker)
            } // checks if it is the first background check.
            else if matchSeeker.backgroundCheck == nil {
                try soulDatesMain.manageBackgroundChecks(currentMatchSeekr: matchSeeker, backgroundCheck: BackgroundCheck(proofOfAge: ProofOfAge(dateIssued: updateProofOfAgeVM.dateIssued, expiryDate: updateProofOfAgeVM.expiryDate, issuer: updateProofOfAgeVM.issuer, proofOfIdNumber: updateProofOfAgeVM.proofOfAgeIdNumber, legalFirstName: updateProofOfAgeVM.legalFirstName, legalLastName: updateProofOfAgeVM.legalLastName, streetAddress: updateProofOfAgeVM.address, dateOfBirth: updateProofOfAgeVM.dateOfBirth )))
            }
        }
        else { // this will set the proofOfAge object to nil if the matchSeeker no longer wants their proof of age.
           try soulDatesMain.manageProofOfAgeCheck(currentMatchSeeker: matchSeeker, proofOfAge: nil)
        }
    }
    
    private func initialiseProofOfAge(matchSeeker: MatchSeeker) throws {
        try soulDatesMain.manageProofOfAgeCheck(currentMatchSeeker: matchSeeker, proofOfAge: ProofOfAge(dateIssued: updateProofOfAgeVM.dateIssued, expiryDate: updateProofOfAgeVM.expiryDate, issuer: updateProofOfAgeVM.issuer, proofOfIdNumber: updateProofOfAgeVM.proofOfAgeIdNumber, legalFirstName: updateProofOfAgeVM.legalLastName, legalLastName: updateProofOfAgeVM.legalLastName, streetAddress: updateProofOfAgeVM.address, dateOfBirth: updateProofOfAgeVM.dateOfBirth))
    }
}

struct UpdateProofOfAgeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProofOfAgeView(updateProofOfAgeVM: UpdateProofOfAgeViewModel(), isOnSession: .constant(true))
            .environmentObject(Session())
            .environmentObject(SoulDatesMain())
    }
}

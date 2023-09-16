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
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var buttonDisabled: Bool = false
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Proof of Age Check", isOn: $updateProofOfAgeVM.isProofOfAge).onChange(of: updateProofOfAgeVM.isProofOfAge) { isProofOfAge in
                        //clears the text fields if they turn of isProofOfAge
                        if !isProofOfAge {
                            //resets the text fields and dates to empty text field and default dates.
                            updateProofOfAgeVM.resetVM()
                        }
                    }
                }
                if updateProofOfAgeVM.isProofOfAge {
                    Section(content: {
                        HStack {
                            Text("ID Number").frame(width: 100, alignment: .leading)
                            Spacer()
                            TextField("ID Number", text: $updateProofOfAgeVM.proofOfAgeIdNumber).keyboardType(.numberPad)
                        }
                        HStack {
                            Text("Issuer").frame(width: 100, alignment: .leading)
                            Spacer()
                            TextField("Issuer", text: $updateProofOfAgeVM.issuer)
                        }
                        DatePicker("Date issued:", selection: $updateProofOfAgeVM.dateIssued, in: ProofOfAge.passedDateRange(), displayedComponents: [.date])
                        DatePicker("Expiry Date", selection: $updateProofOfAgeVM.expiryDate, in: ProofOfAge.futureDateRange(), displayedComponents: [.date])
                    }, header: {
                        Text("Proof of Age Details")
                    }, footer: {
                        Text("This is only a prototype, no API's are being used to verify proof of age.")
                    })
                    Section("Legal Details") {
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
            }
        }.onAppear {
            do {
                try updateVM()
            }
            catch {
                print("match seeker does not exist.")
           }
        }.toolbar{
            Button {
                do {
                    //validates the date of birth
                    try updateProofOfAgeVM.validate()
                    try processData()
                    //goes back to previous view
                    presentationMode.wrappedValue.dismiss()
                }
                catch ProfileError.underAgeException {
                    showAlert = true
                    alertTitle = "Under Age!"
                    alertMessage = "The proof of Age that was provided is under age to be continue using our app."
                }
                catch ProfileError.invalidIDNumber {
                    showAlert = true
                    alertTitle = "Only numerics can be entered"
                    alertMessage = "Your Proof of age ID number must have digits only."
                }
                catch {
                    showAlert = true
                    alertTitle = "Something went wrong!"
                    alertMessage = "Unable to update proof of age details."
                }
            } label: {
                Text("Done")
            }.disabled(buttonDisabled)
        }.onChange(of: updateProofOfAgeVM.allTextEneterd(), perform: { everythingIsEntered in
            if everythingIsEntered {
                buttonDisabled = false
            } else {
                buttonDisabled = true
            }
        }).alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage))
        }.navigationTitle("Proof of Age").navigationBarTitleDisplayMode(.inline)
    }
    //a function that updates the view model from the session once its being viewed.
    func updateVM() throws {
        let matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        if let haveProofOfAge = matchSeeker.backgroundCheck?.proofOfAge {
            updateProofOfAgeVM.isProofOfAge       = true
            updateProofOfAgeVM.address            = haveProofOfAge.streetAddress
            updateProofOfAgeVM.dateIssued         = haveProofOfAge.dateIssued
            updateProofOfAgeVM.dateOfBirth        = haveProofOfAge.dateOfBirth
            updateProofOfAgeVM.legalFirstName     = haveProofOfAge.legalFirstName
            updateProofOfAgeVM.legalLastName      = haveProofOfAge.legalLastName
            updateProofOfAgeVM.issuer             = haveProofOfAge.issuer
            updateProofOfAgeVM.proofOfAgeIdNumber = haveProofOfAge.proofOfIdNumber
            
            
        }
        else {
            updateProofOfAgeVM.isProofOfAge = false
            updateProofOfAgeVM.resetVM()
        }
        print("Testing user defaults \(updateProofOfAgeVM.legalFirstName)")
    }
    
    //this will update the proof of age check details based on scenarios.
    func processData() throws {
        let matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        
        //check if they declared that they have a proofOfAge check
        if updateProofOfAgeVM.isProofOfAge {
            if let haveBackgroundCheck = matchSeeker.backgroundCheck {
                if haveBackgroundCheck.proofOfAge != nil {
                    try soulDatesMain.updateProofOfAgeDetails(currentMatchSeeker: matchSeeker, legalFirstName: updateProofOfAgeVM.legalFirstName, legalLastName: updateProofOfAgeVM.legalLastName, dateIssued: updateProofOfAgeVM.dateIssued, expiryDate: updateProofOfAgeVM.expiryDate, streetAddress: updateProofOfAgeVM.address, dateOfBirth: updateProofOfAgeVM.dateOfBirth, issuer: updateProofOfAgeVM.issuer, proofOfIdNumber: updateProofOfAgeVM.proofOfAgeIdNumber)
                }
                else {
                    try soulDatesMain.manageProofOfAgeCheck(currentMatchSeeker: matchSeeker, proofOfAge: ProofOfAge(dateIssued: updateProofOfAgeVM.dateIssued, expiryDate: updateProofOfAgeVM.expiryDate, issuer: updateProofOfAgeVM.issuer, proofOfIdNumber: updateProofOfAgeVM.proofOfAgeIdNumber, legalFirstName: updateProofOfAgeVM.legalFirstName, legalLastName: updateProofOfAgeVM.legalLastName, streetAddress: updateProofOfAgeVM.address, dateOfBirth: updateProofOfAgeVM.dateOfBirth))
                }
            }
            else { //initialises a new background check instance to the matchSeeker with proof of age check.
                try soulDatesMain.manageBackgroundChecks(currentMatchSeekr: matchSeeker, backgroundCheck: BackgroundCheck(proofOfAge: ProofOfAge(dateIssued: updateProofOfAgeVM.dateIssued, expiryDate: updateProofOfAgeVM.expiryDate, issuer: updateProofOfAgeVM.issuer, proofOfIdNumber: updateProofOfAgeVM.proofOfAgeIdNumber, legalFirstName: updateProofOfAgeVM.legalFirstName, legalLastName: updateProofOfAgeVM.legalLastName, streetAddress: updateProofOfAgeVM.address, dateOfBirth: updateProofOfAgeVM.dateOfBirth)))
            }
        }
        else { // this will set the proofOfAge object to nil if the matchSeeker no longer wants their proof of age.
           try soulDatesMain.manageProofOfAgeCheck(currentMatchSeeker: matchSeeker, proofOfAge: nil)
        }
        //overwrites it to userDefaults
        try session.overWriteMatchSeekertoUserDefautls(soulDatesMain: soulDatesMain)
    }
    
    // a helper function to initilse proof of age check if they already provided a background check instance.
    private func initialiseProofOfAge(matchSeeker: MatchSeeker) throws {
        try soulDatesMain.manageProofOfAgeCheck(currentMatchSeeker: matchSeeker, proofOfAge: ProofOfAge(dateIssued: updateProofOfAgeVM.dateIssued, expiryDate: updateProofOfAgeVM.expiryDate, issuer: updateProofOfAgeVM.issuer, proofOfIdNumber: updateProofOfAgeVM.proofOfAgeIdNumber, legalFirstName: updateProofOfAgeVM.legalFirstName, legalLastName: updateProofOfAgeVM.legalLastName, streetAddress: updateProofOfAgeVM.address, dateOfBirth: updateProofOfAgeVM.dateOfBirth))
    }
}

struct UpdateProofOfAgeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProofOfAgeView(updateProofOfAgeVM: UpdateProofOfAgeViewModel())
            .environmentObject(Session())
            .environmentObject(SoulDatesMain())
    }
}

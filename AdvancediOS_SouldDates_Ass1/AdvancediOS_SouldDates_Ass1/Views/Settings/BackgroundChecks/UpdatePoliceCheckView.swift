//
//  UpdatePoliceCheckView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import SwiftUI

struct UpdatePoliceCheckView: View {
    @ObservedObject var updatePoliceCheckVM: UpdatePoliceCheckViewModel
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @EnvironmentObject var session: Session
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var buttonDisasbled: Bool = false
    
    //this will be used to go back to the previous screen
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Police Check") {
                    Toggle("Do you have police check?", isOn: $updatePoliceCheckVM.isPoliceChecked).onChange(of: updatePoliceCheckVM.isPoliceChecked) {
                        isPoliceChecked in
                        //clears the fields if the user toggles the isPoliceChecked to false
                        if !isPoliceChecked {
                            updatePoliceCheckVM.resetVM() // clears all the fields
                        }
                    }
                }
                //displays more fields relating to police check when it is toggled to true.
                if updatePoliceCheckVM.isPoliceChecked {
                    Section("Police Check Dates") {
                        DatePicker("Date issued:", selection: $updatePoliceCheckVM.issueDate, in: PoliceCheck.passedDateRange(), displayedComponents: [.date])
                        DatePicker("ExpiryDate", selection: $updatePoliceCheckVM.expiryDate, in: PoliceCheck.futureDateRange(), displayedComponents: [.date])
                    }
                    Section("Description") {
                        TextEditor(text: $updatePoliceCheckVM.description)
                    }
                    
                    Section("Criminal Record") {
                        Toggle("Do you have criminal record?", isOn: $updatePoliceCheckVM.isCriminalRecord)
                    }
                }
            }
        }.navigationTitle("Police Check").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                do {
                    //an alert will show if they declare they have a criminal record.
                    if !updatePoliceCheckVM.isCriminalRecord{
                        try processData()
                        //goes back to the previous view
                        presentationMode.wrappedValue.dismiss()
                    }
                    else { // this is funny! shows an alert that they can't process their police check.
                        showAlert = true
                        alertTitle = "Cannot verify police check."
                        alertMessage = "You have not declared that you do not have a criminal record."
                    }
                }
                catch { // shows an alert
                    showAlert = true
                    alertTitle = "Something went wrong!"
                    alertMessage = "Unable to update your police check."
                }
            } label: {
                Text("Done")
            }
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage)
            )
        }.onAppear {
            do {
                //updates the views when launch to check if their police check details are stored.
                let matchSeeker: MatchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
                // this will update the view if there is already a police check in place.
                if let havePoliceCheck = matchSeeker.backgroundCheck?.policeCheck {
                    updatePoliceCheckVM.isPoliceChecked     = true
                    updatePoliceCheckVM.description         = havePoliceCheck.description
                    updatePoliceCheckVM.issueDate           = havePoliceCheck.dateIssued
                    updatePoliceCheckVM.expiryDate          = havePoliceCheck.expiryDate
                }
                else {
                    updatePoliceCheckVM.isPoliceChecked = false
                    updatePoliceCheckVM.resetVM()
                }
            } catch {
                print("The matchSeeker from session does not exist.")
            }
        }.onChange(of: updatePoliceCheckVM.allTextEntered()) { textEneterd in
            //disables the done button if there are no text entered in the text fields.
            if textEneterd {
                buttonDisasbled = false
            } else {
                buttonDisasbled = true
            }
        }
    }
    
    //updates the police check details onto the MatchSeeker object based on different scenarios.
    func processData() throws {
        let matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        //if they toggled the police check to true.
        if updatePoliceCheckVM.isPoliceChecked {
            // if there is already a background check instance
            if let haveBackgroundCheck = matchSeeker.backgroundCheck {
                //if they already provided us with police check details.
                if haveBackgroundCheck.policeCheck != nil {
                    try soulDatesMain.updatePoliceCheckDetails(currentMatchSeeker: matchSeeker, issueDate: updatePoliceCheckVM.issueDate, expiryDate: updatePoliceCheckVM.expiryDate, description: updatePoliceCheckVM.description)
                }
                else {
                    try soulDatesMain.managePoliceCheck(currentMatchSeeker: matchSeeker, policeCheck: PoliceCheck(dateIssued: updatePoliceCheckVM.issueDate, expiryDate: updatePoliceCheckVM.expiryDate, description: updatePoliceCheckVM.description))
                }
            }
            else {
                try soulDatesMain.manageBackgroundChecks(currentMatchSeekr: matchSeeker, backgroundCheck: BackgroundCheck(policeCheck: PoliceCheck(dateIssued: updatePoliceCheckVM.issueDate, expiryDate: updatePoliceCheckVM.expiryDate, description: updatePoliceCheckVM.description)))
            }
        }
        else {
            try soulDatesMain.managePoliceCheck(currentMatchSeeker: matchSeeker, policeCheck: nil)
        }
        try session.overWriteMatchSeekertoUserDefautls(soulDatesMain: soulDatesMain)
    }
}

struct UpdatePoliceCheckView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePoliceCheckView(updatePoliceCheckVM: UpdatePoliceCheckViewModel()).environmentObject(Session()).environmentObject(SoulDatesMain())
    }
}

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
        }.toolbar {
            Button {
                do {
                    if !updatePoliceCheckVM.isCriminalRecord{
                        try processData()
                        //goes back to the previous view
                        presentationMode.wrappedValue.dismiss()
                    }
                    else {
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
                let matchSeeker: MatchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
                // this will update the view if there is already a police check in place.
                if let havePoliceCheck = matchSeeker.backgroundCheck?.policeCheck {
                    updatePoliceCheckVM.isPoliceChecked = true
                    updatePoliceCheckVM.description = havePoliceCheck.description
                    updatePoliceCheckVM.issueDate = havePoliceCheck.dateIssued
                    updatePoliceCheckVM.expiryDate = havePoliceCheck.expiryDate
                }
                else {
                    updatePoliceCheckVM.isPoliceChecked = false
                }
                
            } catch {
                print("The matchSeeker from session does not exist.")
            }
         
            
        }
    }
    
    //updates the police check details onto the MatchSeeker struct based on different scenarios.
    func processData() throws {
        let matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        //checks if the backgroundcheck is nil
        
        if updatePoliceCheckVM.isPoliceChecked {
            if matchSeeker.backgroundCheck == nil {
                try soulDatesMain.manageBackgroundChecks(currentMatchSeekr: matchSeeker, backgroundCheck: BackgroundCheck(policeCheck: PoliceCheck(dateIssued: updatePoliceCheckVM.issueDate, expiryDate: updatePoliceCheckVM.expiryDate, description: updatePoliceCheckVM.description)))
            }
            else {
               try soulDatesMain.updatePoliceCheckDetails(currentMatchSeeker: matchSeeker, issueDate: updatePoliceCheckVM.issueDate, expiryDate: updatePoliceCheckVM.expiryDate, description: updatePoliceCheckVM.description)
                
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

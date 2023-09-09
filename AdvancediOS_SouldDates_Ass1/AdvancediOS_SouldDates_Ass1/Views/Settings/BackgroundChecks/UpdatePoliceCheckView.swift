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
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var navActive: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Police Check") {
                    Toggle("Do you have police check?", isOn: $updatePoliceCheckVM.isPoliceChecked)
                }
                
                if updatePoliceCheckVM.isPoliceChecked {
                    Section("Police Check Dates")
                    {
                        DatePicker("Date issued:", selection: $updatePoliceCheckVM.issueDate, displayedComponents: [.date])
                        DatePicker("ExpiryDate", selection: $updatePoliceCheckVM.expiryDate, displayedComponents: [.date])
                    }
                    Section("Description") {
                        TextEditor(text: $updatePoliceCheckVM.description)
                    }
                    
                    Section("Criminal Record")
                    {
                        Toggle("Do you have criminal record?", isOn: $updatePoliceCheckVM.isCriminalRecord)
                    }
                }
            }
        }.toolbar {
            Button {
                do {
                    if !updatePoliceCheckVM.isCriminalRecord{
                        try processData()
                        navActive = true
                    }
                    else {
                        showAlert = true
                        alertTitle = "Cannot verify police check."
                        alertMessage = "You have not declared that you do not have a criminal record."
                    }
                }
                catch {
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
        }.navigationDestination(isPresented: $navActive, destination: {
            InSessionTabView()
        }).onAppear {
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
    
    func processData() throws {
        var matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        //checks if the backgroundcheck is nil
     
        
        if updatePoliceCheckVM.isPoliceChecked {
            if matchSeeker.backgroundCheck == nil {
                try soulDatesMain.updateMatchSeekerBackgroundCheck(currentMatchSeeker: matchSeeker, backgroundCheck: BackgroundCheck(policeCheck: PoliceCheck(dateIssued: updatePoliceCheckVM.issueDate, expiryDate: updatePoliceCheckVM.expiryDate, description: updatePoliceCheckVM.description)))
            }
            else {
               try soulDatesMain.updatePoliceCheckDetails(currentMatchSeeker: matchSeeker, issueDate: updatePoliceCheckVM.issueDate, expiryDate: updatePoliceCheckVM.expiryDate, description: updatePoliceCheckVM.description)
                
            }
        }
        else {
            try soulDatesMain.updateMatchSeekerBackgroundCheck(currentMatchSeeker: matchSeeker, backgroundCheck: nil)
        }
    }
}

struct UpdatePoliceCheckView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePoliceCheckView(updatePoliceCheckVM: UpdatePoliceCheckViewModel())
    }
}

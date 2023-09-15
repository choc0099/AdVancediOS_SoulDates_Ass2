//
//  UpdateRefereeCheckView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import SwiftUI

struct UpdateRefereeCheckView: View {
    @ObservedObject var updateRefereeVM: UpdateRefereeCheckViewModel
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @EnvironmentObject var session: Session
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @Binding var isOnSession: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle("Referee Check", isOn: $updateRefereeVM.isRefereeChecked)
                if updateRefereeVM.isRefereeChecked {
                    Section("Referee Details") {
                        HStack(spacing: 10) {
                            Text("Referee Name:").frame(width: 128, alignment: .leading)
                            TextField("Name", text: $updateRefereeVM.rafereeName)
                        }
                        DatePicker("Date issued", selection: $updateRefereeVM.dateIssued, displayedComponents: [.date])
                        DatePicker("Expiry Date", selection: $updateRefereeVM.expiryDate, displayedComponents: [.date])
                    }
                    Section("Description")
                    {
                        TextEditor(text: $updateRefereeVM.description)
                    }
                }
            }.toolbar{
                Button {
                    do {
                        try processData()
                        //goes back to previous view
                        presentationMode.wrappedValue.dismiss()
                    }
                    catch {
                        showAlert = true
                        alertTitle = "Something Went Wrong!"
                        alertMessage = "Unable to update referee check."
                    }
                } label: {
                    Text("Done")
                }
            }.onAppear {
                do {
                    //updates the view model.
                    try updateVM()
                }
                catch {
                    print("MatchSeeker does not exist.")
                }
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage)
                )
            }
        }
    }
    // a helper function to update the view model when the view has appeared.
    func updateVM() throws {
        let matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        if let matchSeekerReferee = matchSeeker.backgroundCheck?.refereeCheck {
            updateRefereeVM.isRefereeChecked = true
            updateRefereeVM.dateIssued = matchSeekerReferee.dateIssued
            updateRefereeVM.expiryDate = matchSeekerReferee.expiryDate
            updateRefereeVM.description = matchSeekerReferee.description
            updateRefereeVM.rafereeName = matchSeekerReferee.refereeName
        }
    }
    
    //this will update referee data into the model
    //there are conditional statements that will determine in certain use cases, for example, if they no longer want a refaree check and if the actual background check is not allocated.
    func processData() throws {
        let matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        if updateRefereeVM.isRefereeChecked {
            if matchSeeker.backgroundCheck?.refereeCheck != nil {
                try soulDatesMain.updateRefereeDetails(currentMatchSeeker: matchSeeker, refereeName: updateRefereeVM.rafereeName, description: updateRefereeVM.description, dateIssued: updateRefereeVM.dateIssued, expiryDate: updateRefereeVM.expiryDate)
            }
            else if matchSeeker.backgroundCheck?.refereeCheck == nil && matchSeeker.backgroundCheck != nil {
                try initialiseRefereeCheck(matchSeeker)
            }
            else {
                try soulDatesMain.manageBackgroundChecks(currentMatchSeekr: matchSeeker, backgroundCheck: BackgroundCheck())
                try initialiseRefereeCheck(matchSeeker)
            }
        }
        else {
           try soulDatesMain.manageRefereeCheck(currentMatchSeeker: matchSeeker, refereeCheck: nil)
        }
        
        //overwrites it to userDefaults
        try session.overWriteMatchSeekertoUserDefautls(soulDatesMain: soulDatesMain)
    }
    
    func initialiseRefereeCheck(_ matchSeeker: MatchSeeker) throws {
        try soulDatesMain.manageRefereeCheck(currentMatchSeeker: matchSeeker, refereeCheck: RefereeCheck(dateIssued: updateRefereeVM.dateIssued, expiryDate: updateRefereeVM.expiryDate, refereeName: updateRefereeVM.rafereeName, description: updateRefereeVM.description))
    }
}

struct UpdateRefereeCheckView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRefereeCheckView(updateRefereeVM: UpdateRefereeCheckViewModel(), isOnSession: .constant(false))
    }
}

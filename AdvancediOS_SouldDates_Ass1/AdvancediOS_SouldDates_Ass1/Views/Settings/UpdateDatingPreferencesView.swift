//
//  UpdateDatingPreferencesView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 8/9/2023.
//

import SwiftUI

struct UpdateDatingPreferencesView: View {
    @EnvironmentObject var session: Session
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @ObservedObject var updateDatingPrefVM: UpdateDatingPreferncesViewModel
    @State private var showAlert: Bool = false
    @State private var navActive: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    //this is used to go back to the previous view
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
       
        NavigationStack {
            Form {
                Section("Dating Prefernces") {
                    Picker("Interested in", selection: $updateDatingPrefVM.interestedIn) {
                        ForEach(InterestedIn.allCases) {
                            option in
                            Text(option.rawValue.capitalized)
                        }
                    }.pickerStyle(.navigationLink)
                    
                    Picker("Who are you open with dating?", selection: $updateDatingPrefVM.disabilityPrefernces) {
                        ForEach(DisabilityPreference.allCases)
                        {
                            option in
                            Text(option.rawValue)
                        }
                    }.pickerStyle(.navigationLink)
                }
            }.navigationTitle("Update Dating Preference").navigationBarTitleDisplayMode(.inline).toolbar {
                Button {
                    do {
                        try processData()
                        presentationMode.wrappedValue.dismiss()
                    }
                    catch {
                        showAlert = true
                        alertTitle = "Something went wrong!"
                        alertMessage = "Unable to update dating preferences."
                        print(error)
                    }
                } label: {
                    Text("Done")
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage)
                    )
                }
            }
        }
    }
    
    func processData() throws {
        //gets the matchSeeker from session
        let matchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
       try soulDatesMain.updateMatchSeekerDatingPreference(currentMatchSeeker: matchSeeker, newInterestedIn: updateDatingPrefVM.interestedIn, newDisabilityPrefernce: updateDatingPrefVM.disabilityPrefernces)
        
        //overwrites the dating preferences to userDefaults.
        try session.overWriteMatchSeekertoUserDefautls(soulDatesMain: soulDatesMain)
    }
}

struct UpdateDatingPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDatingPreferencesView(updateDatingPrefVM: UpdateDatingPreferncesViewModel()).environmentObject(Session()).environmentObject(SoulDatesMain())
    }
}

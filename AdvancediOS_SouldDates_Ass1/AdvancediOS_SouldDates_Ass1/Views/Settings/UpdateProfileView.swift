//
//  UpdateProFileView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 4/9/2023.
//

import SwiftUI

struct UpdateProfileView: View {
    @EnvironmentObject var session: Session
    @ObservedObject var updateProfileVM: UpdateProfileViewModel
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @State var showAlert: Bool = false
    @State var navActive: Bool = false
    @State var alertMessage: String = ""
    @State var alertTitle: String = ""
    @Binding var selectedTab: Tab
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Details") {
                    HStack {
                        Text("Screen Name: ")
                        TextField("", text: $updateProfileVM.screenName)
                    }
                    DatePicker("Date of birth:", selection: $updateProfileVM.dateOfBirth, displayedComponents: [.date]).datePickerStyle(.compact)
                    Picker("Gender", selection: $updateProfileVM.gender) {
                        ForEach(Gender.allCases) { gender in
                           Text(gender.rawValue.capitalized)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Bio") {
                    TextEditor(text: $updateProfileVM.bio).frame(minHeight: 150)
                }
                Section("Hobbies") {
                    TextEditor(text: $updateProfileVM.hobbies).frame(minHeight: 150)
                }
                Section("Favourite Music")
                {
                    TextEditor(text: $updateProfileVM.favouriteMusic).frame(minHeight: 150)
                }
            }.navigationTitle("Update Profile").toolbar {
                Button {
                    do {
                        try updateProfileVM.validateDateOfBirth()
                        try processData()
                        selectedTab = .look
                    }
                    catch ProfileError.underAgeException {
                        showAlert = true
                        alertTitle = "Under Age!"
                        alertMessage = "Your updated date of birth is under the age of 18 and can not be used for our services."
                    }
                    catch {
                        
                        alertTitle = "Something went wrong!"
                        alertMessage = "Unable to update matchSeeker Profile Details."
                        print("The MatchSeeker id does not exisit in the SoulDates Main.")
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
        //gets the matchSeeker based on stored matchSeeker id from session
        let allocatedMatchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        
        //edits the profile from the model side
        try soulDatesMain.updateMatchSeekerProfile(currentMatchSeeker: allocatedMatchSeeker, newScreenName: updateProfileVM.screenName, newGender: updateProfileVM.gender, newDateOfBirth: updateProfileVM.dateOfBirth, newBio: updateProfileVM.bio, newHobbies: updateProfileVM.hobbies, newFavouriteMusic: updateProfileVM.favouriteMusic)
        
        //overwrites matchSeeker updated profile to userDefaults
        try session.overWriteMatchSeekertoUserDefautls(soulDatesMain: soulDatesMain)
    }
}

struct UpdateProFileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView(updateProfileVM: UpdateProfileViewModel(), selectedTab: .constant(.settings)).environmentObject(Session())
    }
}

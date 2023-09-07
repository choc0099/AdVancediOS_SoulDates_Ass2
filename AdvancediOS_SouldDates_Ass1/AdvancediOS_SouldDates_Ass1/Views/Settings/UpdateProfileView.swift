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
                        processData()
                        navActive = true
                    }
                    catch {
                        showAlert = true
                    }
                } label: {
                    Text("Done")
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Under Age!"),
                        message: Text("Your updated date of birth is under the age of 18 and can not be used for our services.")
                    )
                }
            }.navigationDestination(isPresented: $navActive) {
                InSessionTabView()
            }
        }
    }
    
    
    
    func processData() {
        //gets the matchSeeker based on stored matchSeeker id from session
        let allocatedMatchSeeker = try! soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        
        //edits the profile from the model side
        soulDatesMain.updateMatchSeekerProfile(currentMatchSeeker: allocatedMatchSeeker, newScreenName: updateProfileVM.screenName, newGender: updateProfileVM.gender, newDateOfBirth: updateProfileVM.dateOfBirth, newBio: updateProfileVM.bio, newHobbies: updateProfileVM.hobbies, newFavouriteMusic: updateProfileVM.favouriteMusic)
        //edits the profile from the session side.
        //session.matchSeeker.editProfile(screenName: updateProfileVM.screenName, gender: updateProfileVM.gender, dateOfBirth: updateProfileVM.dateOfBirth, bio: updateProfileVM.bio, hobbies: updateProfileVM.hobbies, favouriteMusic: updateProfileVM.favouriteMusic)
    }
}

struct UpdateProFileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView(updateProfileVM: UpdateProfileViewModel()).environmentObject(Session())
    }
}

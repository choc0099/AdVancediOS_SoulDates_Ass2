//
//  SettingsView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var updateProfileVM: UpdateProfileViewModel = UpdateProfileViewModel()
    @StateObject var updateDatingPrefVM: UpdateDatingPreferncesViewModel = UpdateDatingPreferncesViewModel()
    @EnvironmentObject var session: Session
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @Binding var selectedTab: Tab
    @Binding var isOnSession: Bool
    @State private var showAlert: Bool = false
    
    var body: some View {
      NavigationStack() {
            List {
                NavigationLink {
                    UpdateProfileView(updateProfileVM: updateProfileVM, selectedTab: $selectedTab)
                } label: {
                    Text("Update Profile")
                }

                NavigationLink {
                    UpdateBackgroundCheckView()
                } label: {
                    Text("Background checks")
                }
             
                NavigationLink {
                    UpdateDatingPreferencesView(updateDatingPrefVM: updateDatingPrefVM)
                } label: {
                    Text("Update Dating Preference")
                }
                
                NavigationLink {
                    UpdateDisabilityDetailsView(updateDisabilityVM: UpdateDisabilityDetailsViewModel(), selectedTab: $selectedTab)
                } label: {
                    Text("Update Disability Details")
                }
                Button {
                    showAlert = true
                } label: {
                    Text("Reset")
                }
            }.navigationTitle("Settings")
        }.onAppear{
            do {
                try transferToUpdateProfileVM()
                try transferToUpdateDatingPrefernceVM()
            } catch {
                print("The matchSeeker on the soulDatesMain does not exist.")
            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Are you sure you want to reset your settings."), message: Text("You will lose your saved data including dreamLists and Match Seeker preferences."), primaryButton: .destructive(Text("Reset"), action: {
                do {
                   try handleReset()
                    //returns back to the WelcomeView
                    withAnimation {
                        isOnSession = false
                    }
                }//performs reset actions
                catch {
                    print("Failed to remove matchSeeker")
                }
                
            }), secondaryButton: .cancel())
        }
    }
    
    //this is a function that will clear all data including matchSeeker details
    //when the function is called.
    func handleReset() throws {
        SessionStorageManager.clearEverthing()
        //removes the allocated matchSeeker from memory.
        try soulDatesMain.removeMatchSeeker(matchSeekerId: session.matchSeekerId)
        //clears the dreamList from memory
        session.clearAllDreamList()
    }
    
    //passes data from the matchseeker that is in a session to the updateMatchSeekerProfileViewModel.
    func transferToUpdateProfileVM() throws {
        let matchSeeker = try getMatchSeekerFromSesstion()
        updateProfileVM.screenName = matchSeeker.screenName
        updateProfileVM.dateOfBirth = matchSeeker.dateOfBirth
        updateProfileVM.favouriteMusic = matchSeeker.favouriteMusic
        updateProfileVM.gender = matchSeeker.gender
        updateProfileVM.hobbies = matchSeeker.hobbies
        updateProfileVM.bio = matchSeeker.bio
    }
    
    //same as above.
    func transferToUpdateDatingPrefernceVM() throws {
        let matchSeeker                         = try getMatchSeekerFromSesstion()
        updateDatingPrefVM.interestedIn         = matchSeeker.datingPreference.interestedIn
        updateDatingPrefVM.disabilityPrefernces = matchSeeker.datingPreference.disabilityPreference
        updateDatingPrefVM.minAge               = matchSeeker.datingPreference.minAge
        updateDatingPrefVM.maxAge               = matchSeeker.datingPreference.maxAge
    }
    
    //returns a match seeker object from it id that is saved in the session.
    func getMatchSeekerFromSesstion() throws -> MatchSeeker {
        return try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedTab: .constant(.settings), isOnSession: .constant(false)).environmentObject(Session()).environmentObject(SoulDatesMain())
    }
}

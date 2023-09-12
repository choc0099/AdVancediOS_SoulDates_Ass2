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
    @State var settingsNavPath: NavigationPath = NavigationPath()
    var body: some View {
      NavigationStack(path: $settingsNavPath) {
            List {
                NavigationLink {
                    UpdateProfileView(updateProfileVM: updateProfileVM, selectedTab: $selectedTab)
                } label: {
                    Text("Update Profile")
                }

                NavigationLink {
                    UpdateBackgroundCheckView(isOnSession: $isOnSession)
                } label: {
                    Text("Background checks")
                }
             
                NavigationLink {
                    UpdateDatingPreferencesView(updateDatingPrefVM: updateDatingPrefVM, isOnSession: $isOnSession)
                } label: {
                    Text("Update Dating Preference")
                }
                
                NavigationLink {
                    UpdateDisabilityDetailsView(updateDisabilityVM: UpdateDisabilityDetailsViewModel(), isOnSession: $isOnSession, selectedTab: $selectedTab)
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
            Alert(title: Text("Are you sure you want to reset your settings."), message: Text("You will lose your saved data including dreamLists and Match Seeker preferences."), primaryButton: .destructive(Text("Yes"), action: {
                //performs reset actions
                handleReset()
                //returns back to the WelcomeView
                isOnSession = false
            }), secondaryButton:.default(Text("No")))
        }
    }
    
    func handleReset() {
        SessionStorageManager.clearEverthing()
        soulDatesMain.removeMatchSeeker(matchSeekerId: session.matchSeekerId)
    }
    
    func transferToUpdateProfileVM() throws {
        
        let matchSeeker = try getMatchSeekerFromSesstion()
        updateProfileVM.screenName = matchSeeker.screenName
        updateProfileVM.dateOfBirth = matchSeeker.dateOfBirth
        updateProfileVM.favouriteMusic = matchSeeker.favouriteMusic
        updateProfileVM.gender = matchSeeker.gender
        updateProfileVM.hobbies = matchSeeker.hobbies
        updateProfileVM.bio = matchSeeker.bio
    }
     
    func transferToUpdateDatingPrefernceVM() throws {
        let matchSeeker = try getMatchSeekerFromSesstion()
        updateDatingPrefVM.interestedIn = matchSeeker.datingPreference.interestedIn
        updateDatingPrefVM.disabilityPrefernces = matchSeeker.datingPreference.disabilityPreference
    }
    
    func getMatchSeekerFromSesstion() throws -> MatchSeeker {
        return try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedTab: .constant(.settings), isOnSession: .constant(false)).environmentObject(Session())
    }
}

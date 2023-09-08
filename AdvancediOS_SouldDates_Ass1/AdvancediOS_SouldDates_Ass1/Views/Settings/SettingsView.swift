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
    var body: some View {
      NavigationStack
        {
            List {
                NavigationLink {
                    UpdateProfileView(updateProfileVM: updateProfileVM)
                } label: {
                    Text("Update Profile")
                }
                
                Text("Background checks")
                NavigationLink {
                    UpdateDatingPreferencesView(updateDatingPrefVM: updateDatingPrefVM)
                } label: {
                    Text("Update Dating Preference")
                }
                
                NavigationLink {
                    UpdateDisabilityDetailsView(updateDisabilityVM: UpdateDisabilityDetailsViewModel())
                } label: {
                    Text("Update Disability Details")
                }
             
                Text("Reset")
            }
        }.onAppear{
            do {
                try transferToUpdateProfileVM()
                try transferToUpdateDatingPrefernceVM()
            } catch {
                print("The matchSeeker on the soulDatesMain does not exist.")
            }
           
        }
       
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
        SettingsView().environmentObject(Session())
    }
}

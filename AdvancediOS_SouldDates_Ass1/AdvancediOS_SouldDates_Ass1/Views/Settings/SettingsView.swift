//
//  SettingsView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var updateProfileVM: UpdateProfileViewModel = UpdateProfileViewModel()
    @EnvironmentObject var session: Session
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    var body: some View {
      NavigationStack
        {
            List() {
                NavigationLink {
                    UpdateProfileView(updateProfileVM: updateProfileVM)
                } label: {
                    Text("Update Profile")
                }
                
                Text("Background checks")
                Text("Update Dating Preference")
                NavigationLink {
                    UpdateDisabilityDetailsView(updateDisabilityVM: UpdateDisabilityDetailsViewModel())
                } label: {
                    Text("Update Disability Details")
                }
             
                Text("Reset")
            }
        }.onAppear{
            transferToUpdateProfileVM()
        }
       
    }
    
    func transferToUpdateProfileVM()
    {
        let matchSeeker = try! soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        updateProfileVM.screenName = matchSeeker.screenName
        updateProfileVM.dateOfBirth = matchSeeker.dateOfBirth
        updateProfileVM.favouriteMusic = matchSeeker.favouriteMusic
        updateProfileVM.gender = matchSeeker.gender
        updateProfileVM.hobbies = matchSeeker.hobbies
        updateProfileVM.bio = matchSeeker.bio
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(Session())
    }
}

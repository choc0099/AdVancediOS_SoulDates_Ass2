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
                Text("Update Disability Details")
                Text("Reset")
            }
        }.onAppear{
            transferToUpdateProfileVM()
        }
       
    }
    
    func transferToUpdateProfileVM()
    {
        let matchSeeker = session.matchSeeker
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
        SettingsView()
    }
}

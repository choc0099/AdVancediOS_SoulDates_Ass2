//
//  UpdateBackgroundCheckView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import SwiftUI

struct UpdateBackgroundCheckView: View {
    @StateObject var updatePoliceCheckVM: UpdatePoliceCheckViewModel = UpdatePoliceCheckViewModel()
    @StateObject var updateProofOfAgeVM: UpdateProofOfAgeViewModel = UpdateProofOfAgeViewModel()
    @StateObject var updateReferreVM: UpdateRefereeCheckViewModel = UpdateRefereeCheckViewModel()
    
    //this is a settings view that lists all the types of background checks.
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    UpdatePoliceCheckView(updatePoliceCheckVM: updatePoliceCheckVM)
                } label: {
                    Text("Police Checks")
                }
                NavigationLink {
                    UpdateProofOfAgeView(updateProofOfAgeVM: updateProofOfAgeVM)
                } label: {
                    Text("Proof of Age")
                }
                NavigationLink {
                    UpdateRefereeCheckView(updateRefereeVM: updateReferreVM)
                } label: {
                    Text("Referee Checks")
                }
            }
        }.navigationTitle("Background Checks").navigationBarTitleDisplayMode(.inline)
    }
}

struct UpdateBackgroundCheckView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateBackgroundCheckView()
    }
}

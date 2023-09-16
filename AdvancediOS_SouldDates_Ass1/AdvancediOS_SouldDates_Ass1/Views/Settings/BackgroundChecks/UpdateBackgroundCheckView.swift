//
//  UpdateBackgroundCheckView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import SwiftUI

struct UpdateBackgroundCheckView: View {
    @StateObject var updatePoliceCheckVM: UpdatePoliceCheckViewModel = UpdatePoliceCheckViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    UpdatePoliceCheckView(updatePoliceCheckVM: updatePoliceCheckVM)
                } label: {
                    Text("Police Checks")
                }
                NavigationLink {
                    UpdateProofOfAgeView(updateProofOfAgeVM: UpdateProofOfAgeViewModel())
                } label: {
                    Text("Proof of Age")
                }
                NavigationLink {
                    UpdateRefereeCheckView(updateRefereeVM: UpdateRefereeCheckViewModel())
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

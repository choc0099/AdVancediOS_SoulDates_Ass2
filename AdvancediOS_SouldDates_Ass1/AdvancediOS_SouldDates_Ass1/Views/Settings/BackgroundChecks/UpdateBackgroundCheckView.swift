//
//  UpdateBackgroundCheckView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import SwiftUI

struct UpdateBackgroundCheckView: View {
    @StateObject var updatePoliceCheckVM: UpdatePoliceCheckViewModel = UpdatePoliceCheckViewModel()
    @Binding var isOnSession: Bool
    var body: some View {
        List {
            NavigationLink {
                UpdatePoliceCheckView(updatePoliceCheckVM: updatePoliceCheckVM, isOnSession: $isOnSession)
            } label: {
                Text("Police Checks")
            }
            NavigationLink {
                UpdateProofOfAgeView(updateProofOfAgeVM: UpdateProofOfAgeViewModel(), isOnSession: $isOnSession)
            } label: {
                Text("Proof of Age")
            }
            NavigationLink {
                UpdateRefereeCheckView(updateRefereeVM: UpdateRefereeCheckViewModel(), isOnSession: $isOnSession)
            } label: {
                Text("Raference Checks")
            }
        }
    }
}

struct UpdateBackgroundCheckView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateBackgroundCheckView(isOnSession: .constant(false))
    }
}

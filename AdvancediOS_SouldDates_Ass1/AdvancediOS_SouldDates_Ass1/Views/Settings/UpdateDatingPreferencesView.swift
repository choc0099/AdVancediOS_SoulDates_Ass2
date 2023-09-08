//
//  UpdateDatingPreferencesView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 8/9/2023.
//

import SwiftUI

struct UpdateDatingPreferencesView: View {
    @EnvironmentObject var session: Session
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @ObservedObject var updateDatingPrefVM: UpdateDatingPreferncesViewModel

    var body: some View {
        Form {
            Section("Dating Prefernces") {
                Picker("Interested in", selection: $updateDatingPrefVM.interestedIn) {
                    ForEach(InterestedIn.allCases) {
                        option in
                        Text(option.rawValue.capitalized)
                    }
                }.pickerStyle(.navigationLink)
                
                Picker("Who are you open with dating?", selection: $updateDatingPrefVM.disabilityPrefernces) {
                    ForEach(DisabilityPreference.allCases)
                    {
                        option in
                        Text(option.rawValue)
                    }
                }.pickerStyle(.navigationLink)
            }
        }
    }
}

struct UpdateDatingPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDatingPreferencesView(updateDatingPrefVM: UpdateDatingPreferncesViewModel())
    }
}

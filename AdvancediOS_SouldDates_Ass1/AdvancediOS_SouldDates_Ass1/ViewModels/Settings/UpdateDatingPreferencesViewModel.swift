//
//  UpdateDatingPreferencesViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 8/9/2023.
//

import Foundation
class UpdateDatingPreferncesViewModel: ObservableObject {
    @Published var interestedIn: InterestedIn = .all
    @Published var disabilityPrefernces: DisabilityPreference = .openMinded
    @Published var minAge: Int = 18
    @Published var maxAge: Int = 30
}

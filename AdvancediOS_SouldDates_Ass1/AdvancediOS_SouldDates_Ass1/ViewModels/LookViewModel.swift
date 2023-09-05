//
//  LookViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 5/9/2023.
//

import Foundation



class LookViewModel: ObservableObject {
    @Published var matchSeeker: MatchSeeker = MatchSeeker(screenName: "", hobbies: "", gender: .male, dateOfBirth: Date.now, bio: "", favourteMusic: "", datingPreference: DatingPreference(interestedIn: .all, disabilityPreference: .openMinded, discloseMyDisability: false))
    @Published var isError: Bool = false
    
    
    
}

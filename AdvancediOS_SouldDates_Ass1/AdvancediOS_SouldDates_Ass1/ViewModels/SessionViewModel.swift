//
//  SessionViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 3/9/2023.
//
// This is for when you are using the dating app to browse other matchseekers and enables you to update your profile.

import Foundation

class Session: ObservableObject {
    @Published var matchSeekerId: UUID = UUID()
    @Published var yourMatches: [MatchSeeker] = []
    @Published var lookError: LookError = .unkown
    
    func gatherMatches(soulDatesMain: SoulDatesMain) {
        do {
            let currentMatchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: matchSeekerId)
            let datingPref: DatingPreference = currentMatchSeeker.datingPreference
            let interestedIn: InterestedIn = datingPref.interestedIn
            let disabilityPref: DisabilityPreference = datingPref.disabilityPreference
            
            yourMatches = try soulDatesMain.tailorMatches(currentMatchSeeker: currentMatchSeeker, interestedIn: interestedIn, disabilityPreference: disabilityPref)
            lookError = .noError
        }
        catch ProfileError.noMatchesFound
        {
            lookError = .noMatches
        }
        catch {
            lookError = .unkown
        }
    }
}

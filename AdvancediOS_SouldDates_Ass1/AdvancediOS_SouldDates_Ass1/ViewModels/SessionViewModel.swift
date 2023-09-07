//
//  SessionViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 3/9/2023.
//
// This is for when you are using the dating app to browse other matchseekers and enables you to update your profile.

import Foundation

class Session: ObservableObject {
    //@Published var matchSeeker: MatchSeeker = MatchSeeker(screenName: "", hobbies: "", gender: .other, dateOfBirth: Date.now, bio: "", favourteMusic: "", datingPreference: DatingPreference(interestedIn: .all, disabilityPreference: .openMinded, discloseMyDisability: false))
    
    var matchSeekerId: UUID = UUID()
    /*
    func startSession(matchSeeker: MatchSeeker)
    {
        self.matchSeeker = matchSeeker
    }*/
}

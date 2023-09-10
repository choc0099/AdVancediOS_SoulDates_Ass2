//
//  AdvancediOS_SouldDates_Ass1App.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 19/8/2023.
//

import SwiftUI

@main
struct AdvancediOS_SouldDates_Ass1App: App {
    @StateObject var session: Session = Session()
    @StateObject var soulDatesMain: SoulDatesMain = SoulDatesMain()
    var body: some Scene {
        
        WindowGroup {
            


            ContentView().onAppear{
                let matchSeeker = MatchSeeker(screenName: "mark", hobbies: "computers", gender: .male, dateOfBirth: Date.now, bio: "I like to use computers", favourteMusic: "Ememin", datingPreference: DatingPreference(interestedIn: .all, disabilityPreference: .openMinded, discloseMyDisability: false))
                soulDatesMain.onboardMatchSeeker(matchSeeker: matchSeeker)
                session.matchSeekerId = matchSeeker.id
            }.environmentObject(session).environmentObject(soulDatesMain)

        }
    }
}

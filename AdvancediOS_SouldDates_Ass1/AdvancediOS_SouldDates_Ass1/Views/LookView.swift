//
//  LookView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct LookView: View {
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    //this is used for the individual matchSeeker accessing the app
    @EnvironmentObject var session: Session
    
    
    var body: some View  {
        NavigationStack {
            
            let datingPref: DatingPreference = session.matchSeeker.datingPreference
            let interestedIn: InterestedIn = datingPref.interestedIn
            let disabilityPref: DisabilityPreference = datingPref.disabilityPreference
            if let thereAreMatches = soulDatesMain.tailorMatches(currentMatchSeeker: session.matchSeeker, interestedIn: interestedIn, disabilityPreference: disabilityPref) {
                List(thereAreMatches) {
                    matchSeeker in
                    NavigationLink {
                        ProfileView(matchSeeker: matchSeeker)
                    } label: {
                        MatchSeekerRow(matchSeeker: matchSeeker)
                    }
                   
                }
                
            } else {
                Text("There are no possible matches at your preference, there are plenty more fish in the sea.")
                    .multilineTextAlignment(.center)
            }
            
        }.navigationBarBackButtonHidden(true).navigationTitle("Look").navigationBarTitleDisplayMode(.large)
    }
}

struct LookView_Previews: PreviewProvider {
    static var previews: some View {
        LookView().environmentObject(SoulDatesMain()).environmentObject(Session())
    }
}

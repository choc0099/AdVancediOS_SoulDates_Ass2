//
//  LookView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

enum LookError {
    case noError
    case noMatches
    case unkown
}

struct LookView: View {
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    //this is used for the individual matchSeeker accessing the app
    @EnvironmentObject var session: Session
    @State var lookError: LookError = .noError
    @State var matches: [MatchSeeker] = []
    
    var body: some View  {
        NavigationStack {
            if(lookError == .noError)
            {
                List(matches) {
                    matchSeeker in
                    NavigationLink {
                        ProfileView(matchSeeker: matchSeeker)
                    } label: {
                        MatchSeekerRow(matchSeeker: matchSeeker)
                    }
                }
            }
            else if (lookError == .noMatches) {
                Text("Sorry, there are no matches found for you, there are plenty of fish in the sea yet to come.")
            }
            else if (lookError == .unkown) {
                Text("Sorry, something went wrong.")
            }
        }.onAppear {
            gatherMatches()
        }.navigationBarBackButtonHidden(true).navigationTitle("Look").navigationBarTitleDisplayMode(.large)
    }
    
    func gatherMatches() {
        
        do {
            let datingPref: DatingPreference = session.matchSeeker.datingPreference
            let interestedIn: InterestedIn = datingPref.interestedIn
            let disabilityPref: DisabilityPreference = datingPref.disabilityPreference
            
            matches = try soulDatesMain.tailorMatches(currentMatchSeeker: session.matchSeeker, interestedIn: interestedIn, disabilityPreference: disabilityPref)
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

struct LookView_Previews: PreviewProvider {
    static var previews: some View {
        LookView().environmentObject(SoulDatesMain()).environmentObject(Session())
    }
}

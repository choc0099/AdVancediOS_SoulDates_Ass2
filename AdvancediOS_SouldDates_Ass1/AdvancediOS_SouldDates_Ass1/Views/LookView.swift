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
    @Binding var selectedTab: Tab
    var body: some View  {
        NavigationStack {
            Group {
                if(lookError == .noError) {
                    List(matches) {
                        matchSeeker in
                        NavigationLink(destination: ProfileView(matchSeeker: matchSeeker, selectedTab: $selectedTab)) {
                            MatchSeekerRow(matchSeeker: matchSeeker, selectedTab: $selectedTab)
                        }
                    }
                }
                else if (lookError == .noMatches) {
                    VStack(spacing: 20) {
                        Text("No Matches").font(.headline)
                        Text("Sorry, there are no matches found for you, there are plenty of fish in the sea yet to come.").font(.body)
                    }
                }
                else if (lookError == .unkown) {
                    Text("Sorry, something went wrong.").font(.headline)
                }
            }.onAppear {
                gatherMatches()
            }
        }
    }
    
    func gatherMatches() {
        do {
            let currentMatchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
            let datingPref: DatingPreference = currentMatchSeeker.datingPreference
            let interestedIn: InterestedIn = datingPref.interestedIn
            let disabilityPref: DisabilityPreference = datingPref.disabilityPreference
            
            matches = try soulDatesMain.tailorMatches(currentMatchSeeker: currentMatchSeeker, interestedIn: interestedIn, disabilityPreference: disabilityPref)
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
        LookView(selectedTab: .constant(.look)).environmentObject(SoulDatesMain()).environmentObject(Session())
    }
}

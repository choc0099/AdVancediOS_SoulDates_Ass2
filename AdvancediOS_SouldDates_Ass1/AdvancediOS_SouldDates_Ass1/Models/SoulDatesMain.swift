//
//  SoulDatesMain.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation

class SoulDatesMain: ObservableObject {
    @Published var matchSeekers: [MatchSeeker]
    
    init(matchSeekers: [MatchSeeker]) {
        self.matchSeekers = matchSeekers
    }
    
    init()
    {
        matchSeekers = matchSeekersSample
    }
    
    func onboardMatchSeeker(matchSeeker: MatchSeeker)
    {
        matchSeekers.append(matchSeeker)
    }
    
    // a helper function to list match seekers based on the type of gender they are interested in.
    private func tailorMatchesByGender(currentMatchSeeker: MatchSeeker, interestedIn: InterestedIn)  -> [MatchSeeker]? {
        var allocatedMatchSeekers: [MatchSeeker] = []
        var listedMatchSeekers: [MatchSeeker] = listMatchesWtithoutCurrentUser(currentMatchSeeker: currentMatchSeeker)
        for matchSeeker in listedMatchSeekers {
            switch interestedIn {
            case .men:
                if matchSeeker.gender == .male {
                    allocatedMatchSeekers.append(matchSeeker)
                }
            case .women:
                if matchSeeker.gender == .female {
                    allocatedMatchSeekers.append(matchSeeker)
                }
            case .both:
                if matchSeeker.gender == .male || matchSeeker.gender == .female {
                    allocatedMatchSeekers.append(matchSeeker)
                }
            case .other:
                if matchSeeker.gender != .male || matchSeeker.gender != .female {
                    matchSeekers.append(matchSeeker)
                }
            case .all:
                matchSeekers.append(matchSeeker)   
            }
        }
        
        if allocatedMatchSeekers.isEmpty {
            return nil
        }
        return allocatedMatchSeekers
    }
    
    private func listMatchesWtithoutCurrentUser(currentMatchSeeker: MatchSeeker) -> [MatchSeeker]
    {
        var listedMatchSekers: [MatchSeeker] = []
        for matchSeeker in matchSeekers {
            if matchSeeker.screenName != currentMatchSeeker.screenName {
                listedMatchSekers.append(matchSeeker)
            }
        }
        return listedMatchSekers
    }
    
    func tailorMatches(currentMatchSeeker: MatchSeeker, interestedIn: InterestedIn, disabilityPreference: DisabilityPreference) -> [MatchSeeker]? {
        // this is another array to get allocated matches that it is based on gender and disabilities
        var finalAllocatedMatchSeekers: [MatchSeeker] = []
        // this will be used to loop for allocated matches based on interested in.
        if let allocatedMatchSeekersByGender = tailorMatchesByGender(currentMatchSeeker: currentMatchSeeker, interestedIn: interestedIn) {
            
            for matchSeeker in allocatedMatchSeekersByGender {
               
                switch disabilityPreference {
                case .withDisability:
                    if matchSeeker.disability != nil {
                        finalAllocatedMatchSeekers.append(matchSeeker)
                    }
                case .withoutDisability:
                    if matchSeeker.disability == nil {
                        finalAllocatedMatchSeekers.append(matchSeeker)
                    }
                case .openMinded:
                    return allocatedMatchSeekersByGender
                }
            }
        }
        if finalAllocatedMatchSeekers.isEmpty {
            return nil
        }
        
        return finalAllocatedMatchSeekers
    }
}

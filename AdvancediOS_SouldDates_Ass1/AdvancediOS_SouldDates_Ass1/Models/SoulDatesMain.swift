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
    private func tailorMatchesByGender(currentMatchSeeker: MatchSeeker, interestedIn: InterestedIn) throws -> [MatchSeeker] {
        var allocatedMatchSeekers: [MatchSeeker] = []
        do {
            let listedMatchSeekers: [MatchSeeker] = try listMatchesWtithoutCurrentUser(currentMatchSeeker: currentMatchSeeker)
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
                        allocatedMatchSeekers.append(matchSeeker)
                    }
                case .all:
                    allocatedMatchSeekers.append(matchSeeker)
                }
            }
            if allocatedMatchSeekers.isEmpty {
                throw ProfileError.noMatchesFound
            }
            return allocatedMatchSeekers
        }
        catch {
            throw ProfileError.noMatchesFound
        }
        
      
    }
    
    private func listMatchesWtithoutCurrentUser(currentMatchSeeker: MatchSeeker) throws -> [MatchSeeker]
    {
        var listedMatchSekers: [MatchSeeker] = []
        for matchSeeker in matchSeekers {
            if matchSeeker.screenName != currentMatchSeeker.screenName {
                listedMatchSekers.append(matchSeeker)
            }
        }
        if listedMatchSekers.isEmpty {
            throw ProfileError.noMatchesFound
        }
        return listedMatchSekers
    }
    
    func tailorMatches(currentMatchSeeker: MatchSeeker, interestedIn: InterestedIn, disabilityPreference: DisabilityPreference) throws -> [MatchSeeker] {
        // this is another array to get allocated matches that it is based on gender and disabilities
        var finalAllocatedMatchSeekers: [MatchSeeker] = []
        // this will be used to loop for allocated matches based on interested in.
        do {
        let allocatedMatchSeekersByGender = try tailorMatchesByGender(currentMatchSeeker: currentMatchSeeker, interestedIn: interestedIn)
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
                    finalAllocatedMatchSeekers.append(matchSeeker)
                }
                if finalAllocatedMatchSeekers.isEmpty {
                    throw ProfileError.noMatchesFound;
                }
            }
            return finalAllocatedMatchSeekers
        }
        catch
        {
            throw ProfileError.noMatchesFound
        }
                
    }
    
}

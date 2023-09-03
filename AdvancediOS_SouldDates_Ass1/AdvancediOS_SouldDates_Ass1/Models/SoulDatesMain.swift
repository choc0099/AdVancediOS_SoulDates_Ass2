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
    // a helper function to list match seekers based on the type of gender they are interested in.
    private func tailorMatchesByGender(interestedIn: InterestedIn) throws -> [MatchSeeker] {
        guard matchSeekers.count > 0 else {
            throw ProfileError.noMatchesFound(message: "No one is registered.")
        }
        var allocatedMatchSeekers: [MatchSeeker] = []
        for matchSeeker in matchSeekers {
            switch interestedIn {
            case .men:
                if matchSeeker.gender == .male {
                    allocatedMatchSeekers.append(matchSeeker)
                } else {
                    throw ProfileError.noMatchesFound(message: "No \(Gender.male.rawValue)")
                }
            case .women:
                if matchSeeker.gender == .female {
                    matchSeekers.append(matchSeeker)
                }
                else {
                    throw ProfileError.noMatchesFound(message: "No \(Gender.female.rawValue)")
                }
            case .both:
                if matchSeeker.gender == .male || matchSeeker.gender == .female {
                    matchSeekers.append(matchSeeker)
                }
                else {
                    throw ProfileError.noMatchesFound(message: "No standard genders.")
                }
            case .other:
                if matchSeeker.gender != .male || matchSeeker.gender != .female {
                    matchSeekers.append(matchSeeker)
                }
                else {
                    throw ProfileError.noMatchesFound(message: "no transgenders or nonbinaries")
                }
            case .all:
                matchSeekers.append(matchSeeker)   
            }
        }
        return allocatedMatchSeekers
    }
    
    func tailorMatches(interestedIn: InterestedIn, disabilityPreference: DisabilityPreference) throws -> [MatchSeeker] {
        // this will be used to loop for allocated matches based on interested in.
        let allocatedMatchSeekersByGender: [MatchSeeker] = try tailorMatchesByGender(interestedIn: interestedIn)
        // this is another array to get allocated matches that it is based on gender and disabilities
        var finalAllocatedMatchSeekers: [MatchSeeker] = []
        
        for matchSeeker in allocatedMatchSeekersByGender {
            switch disabilityPreference {
            case .withDisability:
                if matchSeeker.disability != nil {
                    finalAllocatedMatchSeekers.append(matchSeeker)
                } else {
                    throw ProfileError.noMatchesFound(message: "No matches with disability")
                }
            case .withoutDisability:
                if matchSeeker.disability == nil {
                    finalAllocatedMatchSeekers.append(matchSeeker)
                } else {
                    throw ProfileError.noMatchesFound(message: "No matches without disability")
                }
            case .openMinded:
                return allocatedMatchSeekersByGender
            }
        }
        return finalAllocatedMatchSeekers
        
        
    }
}

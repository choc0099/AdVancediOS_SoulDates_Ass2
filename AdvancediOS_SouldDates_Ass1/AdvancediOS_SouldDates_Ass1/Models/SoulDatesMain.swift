//
//  SoulDatesMain.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation

class SoulDatesMain {
    var matchSeekers: [MatchSeeker]
    
    init(matchSeekers: [MatchSeeker]) {
        self.matchSeekers = matchSeekers
    }
    
    init()
    {
        //creates an empty matchSeeker list.
        matchSeekers = []
    }
    
    func tailorMatchSeekers(interestedIn: InterestedIn) throws -> [MatchSeeker] {
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
}

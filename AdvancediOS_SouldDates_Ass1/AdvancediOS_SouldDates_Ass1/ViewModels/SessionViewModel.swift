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
    @Published var dreamList: [MatchSeeker] = [] //this is used to store dreamLists for potential matchSeekers.
    
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
    
    func addToDreamList( matchSeeker: MatchSeeker) {
        dreamList.append(matchSeeker)
    }
    
    func checkAlreadyAdded(selectedMatchSeeker: MatchSeeker) -> Bool
    {
        for item in dreamList {
            if selectedMatchSeeker.id == item.id {
                return true
            }
        }
        return false
    }
    
    func removeFromDreamList(matchSeeker: MatchSeeker) throws {
        if let index = self.dreamList.firstIndex(where: {$0.id == matchSeeker.id}) {
            self.dreamList.remove(at: index)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    //A function that gets all potential matches that are saved in the dreamList
    //with error handling if there are no matches in the dreamlist.
    func getDreamList() throws -> [MatchSeeker] {
        
        if !self.dreamList.isEmpty
        {
            return self.dreamList
        }
        else {
            throw ProfileError.noMatchesFound
        }
    }
}

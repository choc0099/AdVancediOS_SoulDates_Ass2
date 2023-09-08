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
            let listedMatchSeekers: [MatchSeeker] = try tailorMatchesBasedOnDisability(matchSeeker: currentMatchSeeker)
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
    
    //this method will help reduce the likely hood of getting rejected, it would work if people have a disability and wish to meet people without disabilities or openminded
    //for the matches to appear, the other person would have to be open to dating people with disabilities.
    private func tailorMatchesBasedOnDisability(matchSeeker: MatchSeeker) throws -> [MatchSeeker]
    {
        do {
            let listedMatches: [MatchSeeker] = try listMatchesWtithoutCurrentUser(currentMatchSeeker: matchSeeker)
            var allocatedMatches: [MatchSeeker] = []
            
            //determines if the matchSeeker have a disability
            if matchSeeker.disability != nil && !matchSeeker.datingPreference.riskGettingRejected
            {
                for matchSeeker in listedMatches
                {
                    if matchSeeker.datingPreference.disabilityPreference == .openMinded || matchSeeker.datingPreference.disabilityPreference == .withDisability{
                        allocatedMatches.append(matchSeeker)
                    }
                }
                if allocatedMatches.isEmpty {
                    throw ProfileError.noMatchesFound
                }
            }
            else
            {
                //does not do anything if a person does not declare they have a disability, it would simply return the listed matches.
                return listedMatches
            }
            return allocatedMatches
        }
        catch {
            throw ProfileError.noMatchesFound
        }
      
    }
    
    func updateMatchSeekerProfile(currentMatchSeeker: MatchSeeker, newScreenName: String, newGender: Gender, newDateOfBirth: Date, newBio: String,  newHobbies: String, newFavouriteMusic: String) throws
    {
        if let index = self.matchSeekers.firstIndex(where: { $0.id == currentMatchSeeker.id })
        {
            self.matchSeekers[index].editProfile(screenName: newScreenName, gender: newGender, dateOfBirth: newDateOfBirth, bio: newBio, hobbies: newHobbies, favouriteMusic: newFavouriteMusic)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    func updateMatchSeekerDisability(currentMatchSeeker: MatchSeeker, disability: Disability? = nil, discloseDisability: Bool, riskRejections: Bool) throws
    {
        //checks for the specific matchSeeker
        if let index = self.matchSeekers.firstIndex(where: { $0.id == currentMatchSeeker.id }) {
            //checks if the user has toggled that they have a disability.
            if let haveDisabiliy = disability {
                //checks if they already have a disability and wants to update their disability details
                if self.matchSeekers[index].disability != nil
                {
                    self.matchSeekers[index].disability?.updateDisabilityDetails(disabilities: haveDisabiliy.disabilities, disabilitySeverity: haveDisabiliy.severeity)
                }
                else {
                    self.matchSeekers[index].disability = Disability(disabilities: haveDisabiliy.disabilities, severeity: haveDisabiliy.severeity)
                }
            }
            else {
                self.matchSeekers[index].disability = nil
            }
            //this will also update dating preferneces and privacy relating to disability
            self.matchSeekers[index].datingPreference.updateDisabilityRelatedPreference(discloseDisability: discloseDisability, riskRejections: riskRejections)
        } else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    func updateMatchSeekerDatingPreference(currentMatchSeeker: MatchSeeker, newInterestedIn: InterestedIn, newDisabilityPrefernce: DisabilityPreference) throws
    {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id})
        {
            self.matchSeekers[index].datingPreference.updateDatingPrefernces(interstedIn: newInterestedIn, disabilityPreferences: newDisabilityPrefernce)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
       
    }
    
    func getSpecificMatchSeeker(matchSeekerId: UUID) throws -> MatchSeeker
    {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == matchSeekerId})
        {
            return self.matchSeekers[index]
        }
        throw ProfileError.matchSeekerNotExist
    }
    
    func updateMatchSeekerBackgroundCheck(currentMatchSeeker: MatchSeeker, backgroundCheck: BackgroundCheck?) throws {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id})
        {
            self.matchSeekers[index].backgroundCheck = backgroundCheck
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    func updatePoliceCheckDetails(currentMatchSeeker: MatchSeeker, issueDate: Date, expiryDate: Date, description: String) throws
    {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id})
        {
            self.matchSeekers[index].backgroundCheck?.policeCheck?.updatePoliceCheckDetails(dateIssued: issueDate, expiryDate: expiryDate, description: description)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
}

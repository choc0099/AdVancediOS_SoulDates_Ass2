//
//  SoulDatesMain.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation

//this is the view model that displays a list of matchSeekers in a SwiftUI view.
class SoulDatesMain: ObservableObject {
    @Published var matchSeekers: [MatchSeeker]
    
    init(matchSeekers: [MatchSeeker]) {
        self.matchSeekers = matchSeekers
    }
    
    init()
    {
        //i have decided to use array objects for this assessment instead of JSON.
        matchSeekers = matchSeekersSample
        //sets a fake scammer status for a matchSeeker
        self.matchSeekers[0].toggleScammer()
        
        //sets the fake background check information for a matchSeeker
        self.matchSeekers[1].setBackgroundCheck(backgroundCheck: BackgroundCheck(policeCheck: PoliceCheck(dateIssued: Date.now, expiryDate: Date.now, description: "trustworthy"), proofOfAge: ProofOfAge(dateIssued: Date.now, expiryDate: Date.now, issuer: "NSW", proofOfIdNumber: "122299883", legalFirstName: "Samantha", legalLastName: "Filler", streetAddress: "777 Phill Street, Chipandale", dateOfBirth: Date.now), refereeCheck: RefereeCheck(dateIssued: Date.now, expiryDate: Date.now, refereeName: "Jane", description: "She has done a great job.")))
    }
    
    //this adds the matchSeeker to the matchSeekers list once the user has been registered.
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
                    if matchSeeker.gender != .male && matchSeeker.gender != .female {
                        allocatedMatchSeekers.append(matchSeeker)
                    }
                case .all:
                    allocatedMatchSeekers.append(matchSeeker)
                }
            }
            //throws an exception if there were no matches that are tailored to them.
            if allocatedMatchSeekers.isEmpty {
                throw ProfileError.noMatchesFound
            }
            return allocatedMatchSeekers
        }
        catch {
            //same as above comment
            throw ProfileError.noMatchesFound
        }
        
      
    }
    
    //this is ued to list matches without the current matchSeeker during a session so they can't view themselves as a potential matchSeeker to connect.
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
    
    //this is an overall function that will filter a list of matchSeekers based on their disabiity status and dating preferences
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
        catch {
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
    
    //this is a helper function to update the matchSeeker's profile that is in a matchSeeker list so it updates dyanmicly onto soulDatesMain
    func updateMatchSeekerProfile(currentMatchSeeker: MatchSeeker, newScreenName: String, newGender: Gender, newDateOfBirth: Date, newBio: String,  newHobbies: String, newFavouriteMusic: String) throws {
        if let index = self.matchSeekers.firstIndex(where: { $0.id == currentMatchSeeker.id })
        {
            self.matchSeekers[index].editProfile(screenName: newScreenName, gender: newGender, dateOfBirth: newDateOfBirth, bio: newBio, hobbies: newHobbies, favouriteMusic: newFavouriteMusic)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    //same as above function but updates their disability related details.
    func updateMatchSeekerDisability(currentMatchSeeker: MatchSeeker, disability: Disability? = nil, discloseDisability: Bool, riskRejections: Bool) throws {
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
    
    //does the same sort of things as above function
    func updateMatchSeekerDatingPreference(currentMatchSeeker: MatchSeeker, newInterestedIn: InterestedIn, newDisabilityPrefernce: DisabilityPreference) throws {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id})
        {
            self.matchSeekers[index].datingPreference.updateDatingPrefernces(interstedIn: newInterestedIn, disabilityPreferences: newDisabilityPrefernce)
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
       
    }
    
    //returns a matchSeeker object when trying to find a particular one..
    //this is used on the sessionViewModel with a matchSeeker id assigned instead of creating a matchSeeker object inside session.
    func getSpecificMatchSeeker(matchSeekerId: UUID) throws -> MatchSeeker
    {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == matchSeekerId}) {
            return self.matchSeekers[index]
        }
        throw ProfileError.matchSeekerNotExist
    }
    
    func toggleMatchSeekerScammer(currentMatchSeeker: MatchSeeker) throws {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == currentMatchSeeker.id})
        {
            self.matchSeekers[index].toggleScammer()
        }
        else {
            throw ProfileError.matchSeekerNotExist
        }
    }
    
    //removes a matchSeeker from the list when resetting the session.
    func removeMatchSeeker(matchSeekerId: UUID) throws
    {
        if let index = self.matchSeekers.firstIndex(where: {$0.id == matchSeekerId})
        {
            self.matchSeekers.remove(at: index)
        }
        else {
            throw ProfileError.unableToRemove
        }
    }
}

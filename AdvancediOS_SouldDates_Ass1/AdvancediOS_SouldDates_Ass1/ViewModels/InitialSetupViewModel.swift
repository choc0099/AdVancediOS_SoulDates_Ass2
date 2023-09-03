//
//  InitialSetupViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 2/9/2023.
//

import Foundation
import SwiftUI

class InitialSetupViewModel: ObservableObject {
    @Published var screenName: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var gender: Gender = .male
    @Published var interestedIn: InterestedIn = .all
    //optionals can't be used but instead, there is a seperate bollean to detemrin i a matchseeker have a disability.
    @Published var disability: String = ""
    @Published var disabilitySeverity: DisabilitySeverity = .mild
    @Published var discloseMyDisability: Bool = false
    @Published var isDisabled: Bool = false
    @Published var bio: String = ""
    @Published var hobbies: String = ""
    @Published var favouriteMusic: String = ""
    @Published var disabilityPreference: DisabilityPreference = .openMinded
    
    //a function that will be used to validate the age and names
    func validateBasicDetails() throws {
        guard (!screenName.isEmpty) else {
             throw ProfileError.emptyTextFields
        }
        guard !DateManager.isUnderAge(birthDate: dateOfBirth)
        else {
            throw ProfileError.underAgeException
        }
    }
    
    func validateDisability() throws {
        guard (!disability.isEmpty) else {
            throw ProfileError.emptyTextFields
        }
    }
    
    func validateAboutMe() throws {
        guard !(bio.isEmpty || hobbies.isEmpty || favouriteMusic.isEmpty) else {
            throw ProfileError.emptyTextFields
        }
    }
    
    func convertToObject() -> MatchSeeker {
        var haveDisability: Disability?
        if(isDisabled == true)
        {
            haveDisability = Disability(disabilities: disability, severeity: disabilitySeverity)
        }
        let datingPreferences: DatingPreference = DatingPreference(interestedIn: interestedIn, disabilityPreference: disabilityPreference, discloseMyDisability: discloseMyDisability)
        let matchSeeeker = MatchSeeker(screenName: screenName, hobbies: hobbies, gender: gender, dateOfBirth: dateOfBirth, bio: bio, favourteMusic: favouriteMusic, datingPreference: datingPreferences, disability: haveDisability)
        return matchSeeeker
    }
}


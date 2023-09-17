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
    //optionals can't be used but instead, there is a seperate boolean to detemrine if a matchseeker have a disability.
    @Published var disability: String = ""
    @Published var disabilitySeverity: DisabilitySeverity = .mild
    @Published var discloseMyDisability: Bool = false
    @Published var isDisabled: Bool = false
    @Published var bio: String = ""
    @Published var hobbies: String = ""
    @Published var favouriteMusic: String = ""
    @Published var disabilityPreference: DisabilityPreference = .openMinded
    @Published var minAge: Int = 18
    @Published var maxAge: Int = 30
    
    //this will validate the date of birth to ensure only users who are over 18 can use the app.
    //also in earlier stages before implementing the button to disable, it will show an alert if they have not entered their name.
    func validateBasicDetails() throws {
        guard (!screenName.isEmpty) else {
             throw ProfileError.emptyTextFields
        }
        guard !DateManager.isUnderAge(birthDate: dateOfBirth)
        else {
            throw ProfileError.underAgeException
        }
    }
    
    //used to check if text fields are empty.
    //it was done in earlier stages before implementing the disable button stuffs.
    func validateDisability() throws {
        guard (!disability.isEmpty) else {
            throw ProfileError.emptyTextFields
        }
    }
    
    //same as above
    func validateAboutMe() throws {
        guard !(bio.isEmpty || hobbies.isEmpty || favouriteMusic.isEmpty) else {
            throw ProfileError.emptyTextFields
        }
    }
    
    //converts all the properties related to matchSeeker into a MatchSeeker object to add.
    func convertToObject() -> MatchSeeker {
        var haveDisability: Disability?
        if(isDisabled == true)
        {
            haveDisability = Disability(disabilities: disability, severeity: disabilitySeverity)
        }
        let datingPreferences: DatingPreference = DatingPreference(interestedIn: interestedIn, disabilityPreference: disabilityPreference, discloseMyDisability: discloseMyDisability, minAge: minAge, maxAge: maxAge)
        let matchSeeeker = MatchSeeker(screenName: screenName, hobbies: hobbies, gender: gender, dateOfBirth: dateOfBirth, bio: bio, favourteMusic: favouriteMusic, datingPreference: datingPreferences, disability: haveDisability)
        return matchSeeeker
    }
    
    //this is used to calculate the percentage of the progress view based on the numbers of steps completed during the setup process.
    func calculateProgress(currentStep: Float) -> Float {
        let stepDivision: Float = currentStep / 7
        print(stepDivision)
        return stepDivision
    }
}


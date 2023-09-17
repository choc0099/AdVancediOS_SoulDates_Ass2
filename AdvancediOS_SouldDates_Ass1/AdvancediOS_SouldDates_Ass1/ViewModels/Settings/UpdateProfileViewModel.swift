//
//  UpdateProfileViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 4/9/2023.
//

import Foundation

class UpdateProfileViewModel: ObservableObject {
    @Published var screenName: String = ""
    @Published var dateOfBirth: Date = Date.now
    @Published var bio: String = ""
    @Published var gender: Gender = .other
    @Published var hobbies: String = ""
    @Published var favouriteMusic: String = ""
    
    //validates if the user enters an birthdate that is at an appropriate age when updating their profile.
    func validateDateOfBirth() throws {
        guard !DateManager.isUnderAge(birthDate: dateOfBirth) else {
            throw ProfileError.underAgeException
        }
    }
    
    //this will return a true if all text fields contains text
    //it will be used to determine if the button will be disabled
    func allTextFieldEntered() -> Bool {
        if !screenName.isEmpty && !bio.isEmpty && !favouriteMusic.isEmpty && !hobbies.isEmpty {
            return true
        }
        else {
            return false
        }
    }
}

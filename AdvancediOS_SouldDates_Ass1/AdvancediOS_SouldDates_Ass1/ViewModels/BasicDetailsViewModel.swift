//
//  InitialSetupViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 2/9/2023.
//

import Foundation
import SwiftUI

class BasicDetailsViewModel: ObservableObject {
    @Published var screenName: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var gender: Gender = .male
    @Published var interestedIn: InterestedIn = .all
    
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
}


//
//  Persons.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation
//this is an enum for error handling that is confined with Apple's error protocol.
//it is used for error handling within certain scenarios
//for example, it will throw an error if there are no matchSeekers in an array.
enum ProfileError: Error {
    case underAgeException
    case noMatchesFound
    case matchSeekerNotExist
    case emptyTextFields
    case matchSeekerAlreadyAdded
    case invalidIDNumber
    case unableToRemove
}

//I have decided to use enums for gender, interestedIn and disability preferences
//The enums  makes it easier to access as they have to select an item instead of typing it manuelly.
//and it makes it convienient to filter matches.
enum Gender: String, CaseIterable, Identifiable, Codable {
    case female
    case male
    case nonbinary
    case transgender
    case other
    
    var id: Self {self }
}

enum InterestedIn: String, CaseIterable, Identifiable, Codable {
    case men
    case women
    case both
    case other
    case all
    
    var id: Self {self}
}

enum DisabilityPreference: String, CaseIterable, Identifiable, Codable {
    case withDisability = "People with disabilities"
    case withoutDisability = "People without disabilities"
    case openMinded = "I am open minded!"
    
    var id: Self {self}
}

//the person protocol is a set of properties that are required for this app as ezch person has their own id's and screenNames.
//it can be composed from different persons and must comform to that protocol such as matchSeekers, admins and technical support people.
protocol Person: Identifiable, Decodable {
    var id: UUID {get set}
    var screenName: String {get set}
}

//this struct is currently unused as I have not added the admin-related user story
//but its to explain that it conforms to the person protocol.
struct Admin: Person {
    var id: UUID = UUID()
    var screenName: String
}

//
//  MatchSeekerProfile.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import Foundation

enum Gender {
    case female
    case male
    case nonbinary
    case transgender
    case other
}

enum InterestedIn {
    case men
    case women
    case both
    case other
    case all
}
/*
struct MatchSeeker: MatchSeekerUser {
    var id: UUID = UUID()
    var name: String
    var dateOfBirth: Date
    var age: Int
    var bio: String
    var Hobbies: String
    var favouriteMusic: String
    var favouriteMovie: String
    var sexuality: String
    var gender: String
    var disabilities: String?
    var isScammer: Bool
    

    mutating func setGender(yourGender: Gender) {
        switch yourGender {
        case .male:
            gender = "Male"
        case .female:
            gender = "Female"
        case .nonbinary:
            gender = "Non-binary"
        case .transgender:
            gender = "Transgender"
        default:
            gender = "Other"
        }
    }
}*/

//
//  SoulDatesSampleData.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation


var matchSeekersSample: [MatchSeeker] = [
     MatchSeeker(screenName: "ErinTheBakeBeans", hobbies: "Arts, Dance, Clubbing", gender: .female, dateOfBirth: Date.now, bio: "I like to eat bake beans for breakfast and hang out with my friends at the clubs", favourteMusic: "RUFUS", datingPreference: DatingPreference(interestedIn: .men, disabilityPreference: .withoutDisability, discloseMyDisability: false)),
    MatchSeeker(screenName: "StarlightSam32", hobbies: "Surfing, Dancing, Swimming", gender: .female, dateOfBirth: Date.now, bio: "Hi, my name is Sam and I am working as a support worker at What Ability, I am positive of meeting people with disabilities", favourteMusic: "WILLOW SMITH", datingPreference: DatingPreference(interestedIn: .men, disabilityPreference: .openMinded, discloseMyDisability: false)),
     MatchSeeker(screenName: "redBen", hobbies: "Going to the gym", gender: .male, dateOfBirth: Date.now, bio: "Hi, my name is Ben, I work at DSA packing up chocolates", favourteMusic: "Junior Jack: My feeling", datingPreference: DatingPreference(interestedIn: .men, disabilityPreference: .withDisability, discloseMyDisability: true), disability: Disability(disabilities: "Intelectual disability", severeity: .moderate)),
     MatchSeeker(screenName: "mrAlexJoke", hobbies: "coding, music, smoking cigarettes", gender: .male, dateOfBirth: Date.now, bio: "Hi my name is Alex and I like to do programming for a living, I am lookinf for a girl who is affectionate", favourteMusic: "Hurricane", datingPreference: DatingPreference(interestedIn: .women, disabilityPreference: .openMinded, discloseMyDisability: true), disability: Disability(disabilities: "Autism Spectrum Disorder", severeity: .mild))
]

var soulDatesBackBon = SoulDatesMain(matchSeekers: matchSeekersSample)

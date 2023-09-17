//
//  SoulDatesSampleData.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import Foundation


var matchSeekersSample: [MatchSeeker] = [
    MatchSeeker(screenName: "ErinBarMotion", hobbies: "Arts, Dance, Clubbing", gender: .female, dateOfBirth: DateManager.setDate(day: 20, month: 05, year: 1990)!, bio: "I like to eat bake beans for breakfast and hang out with my friends at the clubs", favourteMusic: "RUFUS", datingPreference: DatingPreference(interestedIn: .men, disabilityPreference: .withoutDisability, discloseMyDisability: false), imageName: "women1"),
    MatchSeeker(screenName: "StarlightSam32", hobbies: "Surfing, Dancing, Swimming", gender: .female, dateOfBirth: DateManager.setDate(day: 6, month: 6, year: 2000)!, bio: "Hi, my name is Sam and I am working as a support worker in a disability service provider, I am positive of meeting people with disabilities.", favourteMusic: "WILLOW SMITH", datingPreference: DatingPreference(interestedIn: .men, disabilityPreference: .openMinded, discloseMyDisability: false), imageName: "women2"),
    MatchSeeker(screenName: "ben10", hobbies: "Going to the gym", gender: .male, dateOfBirth: DateManager.setDate(day: 12, month: 02, year: 1995)!, bio: "Hi, my name is Ben, I work at a factory packing up chocolates", favourteMusic: "Junior Jack: My feeling", datingPreference: DatingPreference(interestedIn: .men, disabilityPreference: .withDisability, discloseMyDisability: true), disability: Disability(disabilities: "Intelectual disability", severeity: .moderate), imageName: "men1"),
    MatchSeeker(screenName: "mrAlexJoke", hobbies: "coding, music, smoking cigarettes", gender: .male, dateOfBirth: DateManager.setDate(day: 30, month: 01, year: 1989)!, bio: "Hi my name is Alex and I like to do programming for a living, I am lookinf for a girl who is affectionate", favourteMusic: "Hurricane", datingPreference: DatingPreference(interestedIn: .women, disabilityPreference: .openMinded, discloseMyDisability: true), disability: Disability(disabilities: "Autism Spectrum Disorder", severeity: .mild), imageName: "men2"),
    MatchSeeker(screenName: "thaiCake", hobbies: "Playing guitar", gender: .transgender, dateOfBirth: DateManager.setDate(day: 01, month: 01, year: 2001)!, bio: "I am into dogs and cats", favourteMusic: "Wu-Tang", datingPreference: DatingPreference(interestedIn: .other, disabilityPreference: .openMinded, discloseMyDisability: false))
]

var soulDatesBackBon = SoulDatesMain(matchSeekers: matchSeekersSample)

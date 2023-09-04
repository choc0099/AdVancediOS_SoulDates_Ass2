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
    
}

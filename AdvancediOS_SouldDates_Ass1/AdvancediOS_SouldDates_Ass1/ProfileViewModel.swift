//
//  ProfileViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 4/9/2023.
//

import Foundation

class ProfileViewModel: ObservableObject
{
    @Published var matchSeeker: MatchSeeker
    
    init(matchSeeker: MatchSeeker)
    {
        self.matchSeeker = matchSeeker
    }
    
    
    func getDisabledText() -> String?
    {
        var disabledText: String?
        if let haveDisability = matchSeeker.disability {
            disabledText = "\(haveDisability.disabilities), \(haveDisability.severeity.rawValue.capitalized)"
        }
        else {
            if matchSeeker.datingPreference.disabilityPreference == .openMinded
            {
                disabledText = "Positive about disabled."
            }
        }
        return disabledText
    }
    
}

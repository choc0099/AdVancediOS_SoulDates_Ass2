//
//  UpdateDisabilityDetailsViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 5/9/2023.
//

import Foundation

class UpdateDisabilityDetailsViewModel: ObservableObject {
    @Published var matchSeekerId: UUID = UUID()
    @Published var isDisabled: Bool = false
    @Published var disability: String?
    @Published var disabilitySeverity: DisabilitySeverity?
    @Published var discloseMyDisability: Bool = false
    @Published var riskGettingRejected: Bool = false // this will enable people to view more matches to people that does not declare that they are open minded.
    
    //this will clear all the inputs stored in the VM after the user has turned off the isDisabled toggle
    func resetVM() {
        disability = nil
        disabilitySeverity = nil
    }
}

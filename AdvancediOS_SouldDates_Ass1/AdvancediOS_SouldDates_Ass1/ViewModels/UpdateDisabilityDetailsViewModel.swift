//
//  UpdateDisabilityDetailsViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 5/9/2023.
//

import Foundation

class UpdateDisabilityDetailsViewModel: ObservableObject {
    @Published var isDisabled: Bool = false
    @Published var disability: String?
    @Published var disabilitySeverity: DisabilitySeverity?
    @Published var discloseMyDisability: Bool = false
}

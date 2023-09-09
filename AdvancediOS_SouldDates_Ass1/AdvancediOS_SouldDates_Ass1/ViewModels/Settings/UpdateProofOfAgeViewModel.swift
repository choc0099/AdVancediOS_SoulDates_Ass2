//
//  UpdateProofOfAgeViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import Foundation

class UpdateProofOfAgeViewModel: ObservableObject {
    @Published var isProofOfAge: Bool = false
    @Published var proofOfAgeIdNumber: String = ""
    @Published var dateIssued: Date = Date()
    @Published var expiryDate: Date = Date()
    @Published var issuer: String = ""
    @Published var legalFirstName: String = ""
    @Published var legalLastName: String = ""
    @Published var address: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var session: Session = Session()
    @Published var soulDatesMain: SoulDatesMain = SoulDatesMain()
}

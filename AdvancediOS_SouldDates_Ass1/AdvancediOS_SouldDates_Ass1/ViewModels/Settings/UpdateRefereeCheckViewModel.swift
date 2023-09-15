//
//  UpdateRefereeCheckViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import Foundation

class UpdateRefereeCheckViewModel: ObservableObject
{
    @Published var isRefereeChecked: Bool = false
    @Published var dateIssued: Date = Date()
    @Published var expiryDate: Date = Date()
    @Published var rafereeName: String = ""
    @Published var description: String = ""
    
    //resets the fields
    func resetVM() {
        self.dateIssued = Date.now
        self.expiryDate = Date.now
        self.description = ""
        self.rafereeName = ""
    }
}

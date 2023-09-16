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
    @Published var refereeName: String = ""
    @Published var description: String = ""
    
    //resets the fields
    func resetVM() {
        self.dateIssued = Date.now
        self.expiryDate = Date.now
        self.description = ""
        self.refereeName = ""
    }
    
    
    //this is a function that returns a boolean
    //if they declare they have a referee check
    //that will be used to disable the done button accordingly
    //if they have not filled in their details, the button is disabled
    //it will also return true even if they did not fill in their detials if they chose to no longer provide a referee check.
    func allTextEnetered() -> Bool {
        if isRefereeChecked {
            if !refereeName.isEmpty && !description.isEmpty {
                return true
            } else {
                return false
            }
        }
        return true
    }
}

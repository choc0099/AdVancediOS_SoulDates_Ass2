//
//  UpdatePoliceCheckViewModel.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import Foundation

class UpdatePoliceCheckViewModel : ObservableObject {
    @Published var isPoliceChecked: Bool = false
    @Published var issueDate: Date = Date()
    @Published var expiryDate: Date = Date()
    @Published var description: String = ""
    @Published var isCriminalRecord: Bool = false
    
    //resets the view model fields
    func resetVM() {
        self.issueDate = Date.now
        self.expiryDate = Date.now
        self.description = ""
        self.isCriminalRecord = false
    }
    
    //please refer to updateDisabilityVM as it is the same type of method.
    func allTextEntered() -> Bool {
        if isPoliceChecked {
            if !description.isEmpty {
                return true
            }
            return false
        }
        return true
    }
    
}

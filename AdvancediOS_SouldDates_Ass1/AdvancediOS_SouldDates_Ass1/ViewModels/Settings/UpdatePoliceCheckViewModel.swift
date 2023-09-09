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
}

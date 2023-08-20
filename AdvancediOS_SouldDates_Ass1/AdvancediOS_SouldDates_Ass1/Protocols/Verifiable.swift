//
//  Verifiable.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import Foundation

protocol Verifiable {
    var referenceNumber: Int64 {get set}
    var expiryDate: Date {get set}
    var dateIssued: Date {get set}
    var type: String {get set}
    
    func validate()
}
